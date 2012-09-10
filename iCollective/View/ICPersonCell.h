#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface ICPersonCell : UITableViewCell <RKRequestDelegate>
@property(weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property(weak, nonatomic) IBOutlet UIImageView *personImage;
@property(strong, nonatomic) NSString* personUrl;
@end