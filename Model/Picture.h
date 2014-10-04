#import "_Picture.h"

@interface Picture : _Picture {}

- (void)loadImageFromURL:(NSURL *)url withCompetition:(void (^)())callback;
// Custom logic goes here.
@end
