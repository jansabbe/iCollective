#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface ICImageCell : UITableViewCell <RKRequestDelegate>
@property(weak, nonatomic) IBOutlet UILabel *bigLabel;
@property(weak, nonatomic) IBOutlet UIImageView *socialTextImage;
@property(strong, nonatomic) NSString* socialTextImageUrl;
@end