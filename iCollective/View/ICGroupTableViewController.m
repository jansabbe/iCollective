#import "ICGroupTableViewController.h"
#import "ICGroup.h"
#import "ICSignalTableViewController.h"
#import <RestKit/RestKit.h>
#import <RestKit/UI.h>
#import "RKGHLoadingView.h"

@interface ICGroupTableViewController ()
@property(nonatomic, strong) RKFetchedResultsTableController *tableController;
@end


@implementation ICGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableController];
}

- (void)configureTableController {
    self.tableController = [[RKObjectManager sharedManager] fetchedResultsTableControllerForTableViewController:self];
    self.tableController.resourcePath = @"/groups";
    self.tableController.autoRefreshFromNetwork = YES;
    self.tableController.pullToRefreshEnabled = YES;

    
    RKGHLoadingView *loadingView = [[RKGHLoadingView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    loadingView.center = self.tableView.center;
    self.tableController.loadingView = loadingView;
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    self.tableController.sortDescriptors = [NSArray arrayWithObject:descriptor];

    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.cellClassName = @"ICImageCell";
    cellMapping.reuseIdentifier = @"group";

    [cellMapping mapKeyPath:@"name" toAttribute:@"bigLabel.text"];
    [cellMapping mapKeyPath:@"groupPicUrl" toAttribute:@"socialTextImageUrl"];

    [self.tableController mapObjectsWithClass:[ICGroup class] toTableCellsWithMapping:cellMapping];
    [self.tableController loadTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableController loadTable];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGroup"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ICGroup *group = [self.tableController objectForRowAtIndexPath:indexPath];
        ICSignalTableViewController* controller = segue.destinationViewController;
        controller.group = group;
    }
}
@end