//
//  NewsViewController.m
//  VkClient
//
//  Created by 1 1 on 22.08.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsManager.h"
#import "User.h"
#import "NewsCell.h"
#import "News.h"
#import "Picture.h"
#import "NewsDetailsViewController.h"

@interface NewsViewController ()

@property(nonatomic, strong) NewsManager *newsManager;

@end

@implementation NewsViewController

static CGFloat const imageViewSize = 107;
static CGFloat const endScrollingHeight = 50.0;
static NSString *const placeholderImageName = @"placeholder";
static NSString *const cellIdentifier = @"News";
NSString *const newsLoadedNotificationName = @"newsLoaded";
NSString *const pictureLoadedNotificationName = @"pictureLoaded";
NSString *const avatarLoadedNotificationName = @"avatarLoaded";

- (void)viewDidLoad {
    [super viewDidLoad];
    _newsManager = [[NewsManager alloc] initWithUser:_user];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshNews) forControlEvents:UIControlEventValueChanged];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newsUpdated) name:newsLoadedNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureLoaded:) name:pictureLoadedNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avatarLoaded:) name:avatarLoadedNotificationName object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _newsManager.news.count;
}

#pragma mark UITableView data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *newsCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [newsCell hideImageViews];
    News *news = _newsManager.news[(NSUInteger) indexPath.row];
    [self configureBasicCell:newsCell withNews:news];

    NSArray *attachedImageViews = newsCell.attachedImages;                                         //set images in cell if needed
    if (news.hasPictureValue) {
        NSArray *attachedPictures = [news.pictures allObjects];
        if (attachedPictures.count == 0){
            [newsCell setPlaceholderImage:[UIImage imageNamed:placeholderImageName]];
        }
        for (NSUInteger i = 0; i < attachedImageViews.count && i < attachedPictures.count; i++) {
            Picture *attachedPicture = attachedPictures[i];
            [newsCell setAttachedImageWithPictureData:attachedPicture.pictureData andNumber:i];
        }
    }

    if (news.avatar)
        [newsCell setAvatarWithData:news.avatar.pictureData];

    return newsCell;
}

- (void)configureBasicCell:(NewsCell *)cell withNews:(News *)news {
    cell.nameLabel.text = news.ownersName;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    cell.dateLabel.text = [dateFormatter stringFromDate:news.date];

    cell.newsTextLabel.text = news.text;


    if (![news hasPicture]) {
        [cell setImageViewsHeight:0];
    }
    else {
        [cell setImageViewsHeight:imageViewSize];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = _newsManager.news[(NSUInteger) indexPath.row];

    static dispatch_once_t onceToken;
    static NewsCell *sizingCell;
    dispatch_once(&onceToken, ^() {
        sizingCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    });
    [sizingCell hideImageViews];
    [self configureBasicCell:sizingCell withNews:news];

    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize cellSize = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat height = cellSize.height;
    return height;
}


#pragma mark observer methods

- (void)newsUpdated {
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)pictureLoaded:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    int pictureNumber = [(NSNumber *) info[pictureNumberKey] intValue];
    int newsNumber = [(NSNumber *) info[newsNumberKey] intValue];
    NSData *pictureData = info[attachmentPhotoKey];

    NewsCell *newsCell = (NewsCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:newsNumber inSection:0]];
    if (!newsCell)
        return;

    if (pictureData && pictureNumber < newsCell.attachedImages.count) {
        [newsCell setAttachedImageWithPictureData:pictureData andNumber:(NSUInteger) pictureNumber];
        // [newsCell setNeedsLayout];
    }
}

- (void)avatarLoaded:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    int newsNumber = [(NSNumber *) info[newsNumberKey] intValue];
    NSData *pictureData = info[attachmentPhotoKey];

    NewsCell *newsCell = (NewsCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:newsNumber inSection:0]];
    if (!newsCell)
        return;

    if (pictureData)
        [newsCell setAvatarWithData:pictureData];
}

#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollingHeight = scrollView.frame.size.height + scrollView.contentOffset.y;
    if (scrollingHeight > scrollView.contentSize.height + endScrollingHeight) {
        if (!self.tableView.tableFooterView) {
            [self addFooterView];
        }
        [(UIActivityIndicatorView *) self.tableView.tableFooterView startAnimating];
    }
    else if (scrollingHeight < scrollView.contentSize.height) {
        [self removeFooterView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat scrollingHeight = scrollView.frame.size.height + scrollView.contentOffset.y;
    if (scrollingHeight > scrollView.contentSize.height + endScrollingHeight) {
        [self loadOldNews];
    }
}


#pragma mark pull-to-refresh

- (void)refreshNews {
    [_newsManager requestUsersNews];
}

- (void)loadOldNews {
    [_newsManager requestUsersOldNews];
}

- (void)addFooterView {
    UIActivityIndicatorView *footer = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.tableView.tableFooterView = footer;
}

- (void)removeFooterView {
    [self.tableView.tableFooterView removeFromSuperview];
    self.tableView.tableFooterView = nil;
}

#pragma mark navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NewsDetailsViewController *destination = segue.destinationViewController;
    News *news = _newsManager.news[[self.tableView indexPathForSelectedRow].row];
    destination.news = news;
}

@end