#import "ICGroupTableViewController.h"
#import "ICGroup.h"

@interface ICGroupTableViewController ()
@property(nonatomic, strong) NSFetchedResultsController *tableController;
@end


@implementation ICGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGroup"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //ICGroup *group = [self.tableController objectForRowAtIndexPath:indexPath];
        //ICSignalTableViewController* controller = segue.destinationViewController;
        //controller.group = group;
    }
}
@end