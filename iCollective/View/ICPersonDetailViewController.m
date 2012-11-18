#import "ICPersonDetailViewController.h"
#import "ICPerson.h"

@interface ICPersonDetailViewController ()
@property(nonatomic, strong) NSMutableArray *hiddenPaths;
@end

@implementation ICPersonDetailViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenPaths = [[NSMutableArray alloc] init];

    self.fullNameLabel.text = self.person.fullName;
    self.mailadresLabel.text = self.person.username;


    if (self.person.homePhone.length > 0) {
        self.homePhoneLabel.text = self.person.homePhone;
    } else {
        [self.hiddenPaths addObject:[NSIndexPath indexPathForRow:0 inSection:1]];
    }

    if (self.person.mobilePhone.length > 0) {
        self.mobilePhoneLabel.text = self.person.mobilePhone;
    } else {
        [self.hiddenPaths addObject:[NSIndexPath indexPathForRow:1 inSection:1]];
    }

    if (self.person.workPhone.length > 0) {
        self.workPhoneLabel.text = self.person.workPhone;
    } else {
        [self.hiddenPaths addObject:[NSIndexPath indexPathForRow:2 inSection:1]];
    }


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.hiddenPaths containsObject:indexPath]) {
        return 0;
    }

    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.hiddenPaths containsObject:indexPath]) {
        [cell setHidden:YES];
    }
}

- (void)dealloc {

}

@end