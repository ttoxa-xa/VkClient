//
//  ViewController.m
//  VkClient
//
//  Created by 1 1 on 30.07.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountsManager.h"
#import "OauthViewController.h"
#import "User.h"
#import "NewsViewController.h"

@interface LoginViewController ()

@property(nonatomic, strong) AccountsManager *accountsManager;
@property(nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation LoginViewController

NSString *const newUserAddedNotificationName = @"userAdded";
static NSString *const cellReuseIdentifier = @"AccountCell";
static NSString *const segueId = @"toNews";

- (void)viewDidLoad {
    [super viewDidLoad];
    _accountsManager = [[AccountsManager alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCoreDataUpdated:) name:newUserAddedNotificationName object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _accountsManager.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    User *user = _accountsManager.users[(NSUInteger) indexPath.row];
    cell.textLabel.text = [user first_name];
    /*[UIImage loadImageFromURL:[NSURL URLWithString:user.photo_medium]withCompetition:^(UIImage *img) {
        UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
        if (updateCell){
            if (!updateCell.imageView.image){
                [updateCell.imageView setImage:img];
                [updateCell setNeedsLayout];
            }
        }
    }];*/
    return cell;
}

#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _accountsManager.currentUser = _accountsManager.users[(NSUInteger) indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:segueId sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_accountsManager.users[(NSUInteger) indexPath.row] deleteEntity];
        [_accountsManager.users removeObjectAtIndex:(NSUInteger) indexPath.row];
        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            [tableView reloadData];
        }];
    }
}

#pragma mark navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;
    if ([destination isKindOfClass:[OauthViewController class]]) {
        ((OauthViewController *) destination).accountsManager = _accountsManager;
    }
    else if ([destination isKindOfClass:[NewsViewController class]]) {
        NewsViewController *newsViewController = (NewsViewController *) destination;
        newsViewController.user = _accountsManager.currentUser;
    }
}

#pragma mark observer method

- (void)didCoreDataUpdated:(NSNotification *)notification {
    [_tableView reloadData];
    [self performSegueWithIdentifier:segueId sender:self];
}

@end
