#import <CoreData/CoreData.h>
#import "ICStubCoreDataContext.h"
#import "ICIncrementalStore.h"
#import "ICUserStub.h"
#import "ICUser.h"


@implementation ICStubCoreDataContext

+ (ICStubCoreDataContext *)inMemoryContext {
    return [[self alloc] initWithInMemory];
}

+ (ICStubCoreDataContext *)socialTextContext:(ICUser *)user {
    return [[self alloc] initWithSocialTextContext:user];
}

- (id)initWithSocialTextContext:(ICUser *)user {
    self = [super init];
    if (self) {
        self.model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
        self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        ICIncrementalStore *store = (ICIncrementalStore *) [self.coordinator addPersistentStoreWithType:[ICIncrementalStore type]
                                                                                          configuration:nil URL:nil options:nil error:NULL];

        NSDictionary *options = @{
            NSInferMappingModelAutomaticallyOption : @(YES),
            NSMigratePersistentStoresAutomaticallyOption: @(YES)
        };
        [store.backingPersistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                              configuration:nil URL:nil options:options error:nil];
        store.HTTPClient = (id) [user socialTextClient];
        self.store = store;
        self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.context.persistentStoreCoordinator = self.coordinator;
    }
    return self;
}

- (id)initWithInMemory {
    self = [super init];
    if (self) {
        self.model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
        self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        self.store = [self.coordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                    configuration:nil URL:nil options:nil error:NULL];

        self.context = [[NSManagedObjectContext alloc] init];
        self.context.persistentStoreCoordinator = self.coordinator;
    }
    return self;
}


@end