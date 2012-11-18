#import <Foundation/Foundation.h>

@class ICPerson;


@interface ICPersonDetailViewController : UITableViewController
@property(strong, nonatomic) ICPerson *person;
@property(weak, nonatomic) IBOutlet UIImageView *photo;
@property(weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *mailadresLabel;
@property(weak, nonatomic) IBOutlet UILabel *homePhoneLabel;
@property(weak, nonatomic) IBOutlet UILabel *mobilePhoneLabel;
@property(weak, nonatomic) IBOutlet UILabel *workPhoneLabel;


@end