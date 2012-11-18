#import <CoreData/CoreData.h>
#import "ICStubCoreDataContext.h"


@implementation ICStubCoreDataContext

+ (ICStubCoreDataContext *) inMemoryContext {
    return [[self alloc] initWithInMemory];
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