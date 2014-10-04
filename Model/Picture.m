#import "Picture.h"


@interface Picture ()

// Private interface goes here.

@end


@implementation Picture

- (void)loadImageFromURL:(NSURL *)url withCompetition:(void (^)())callback {
    dispatch_queue_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(downloadQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        self.pictureData = imageData;
        dispatch_async(dispatch_get_main_queue(), ^{
            callback();
        });
    });
}

// Custom logic goes here.

@end
