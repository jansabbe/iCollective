#import <Foundation/Foundation.h>


@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSPersistentStore;
@class NSManagedObjectContext;
@class ICUser;

@interface ICStubCoreDataContext : NSObject

@property(nonatomic, strong) NSManagedObjectModel *model;
@property(nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property(nonatomic, strong) NSPersistentStore *store;
@property(nonatomic, strong) NSManagedObjectContext *context;

+ (ICStubCoreDataContext *)inMemoryContext;

+ (ICStubCoreDataContext *)socialTextContext:(ICUser *)user;


@end