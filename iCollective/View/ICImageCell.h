#import <Foundation/Foundation.h>


@interface ICImageCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UILabel *bigLabel;
@property(weak, nonatomic) IBOutlet UIImageView *socialTextImage;
@property(strong, nonatomic) NSString *socialTextImageUrl;
@end