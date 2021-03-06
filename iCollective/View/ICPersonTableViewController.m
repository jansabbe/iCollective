#import "ICPersonTableViewController.h"
#import "ICPerson.h"
#import "ICPersonDetailViewController.h"
#import <RestKit/UI.h>
#import <RestKit/RestKit.h>
#import "RKGHLoadingView.h"

@interface ICPersonTableViewController ()
@property(nonatomic, strong) RKFetchedResultsTableController *tableController;
@end

@implementation ICPersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableController];
}

- (void)configureTableController {
    self.tableController = [[RKObjectManager sharedManager] fetchedResultsTableControllerForTableViewController:self];
    self.tableController.resourcePath = @"/people?fields=home_phone,work_phone,mobile_phone";
    self.tableController.autoRefreshFromNetwork = YES;
    self.tableController.pullToRefreshEnabled = YES;
    self.tableController.sectionNameKeyPath = @"fullName";
    self.tableController.showsSectionIndexTitles = YES;

    
    RKGHLoadingView *loadingView = [[RKGHLoadingView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    loadingView.center = self.tableView.center;
    self.tableController.loadingView = loadingView;
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"fullName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    self.tableController.sortDescriptors = [NSArray arrayWithObject:descriptor];

    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.cellClassName = @"ICImageCell";
    cellMapping.reuseIdentifier = @"person";

    [cellMapping mapKeyPath:@"fullName" toAttribute:@"bigLabel.text"];
    [cellMapping mapKeyPath:@"photoUrl" toAttribute:@"socialTextImageUrl"];

    [self.tableController mapObjectsWithClass:[ICPerson class] toTableCellsWithMapping:cellMapping];
    [self.tableController loadTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableController loadTable];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPerson"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ICPerson *person = [self.tableController objectForRowAtIndexPath:indexPath];
        ICPersonDetailViewController *controller = segue.destinationViewController;
        controller.person = person;
    }
}

@end