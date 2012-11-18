#import "ICPersonTableViewController.h"
#import "ICPerson.h"

@interface ICPersonTableViewController ()
@property(nonatomic, strong) NSFetchedResultsController *tableController;
@end

@implementation ICPersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPerson"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    }
}

@end