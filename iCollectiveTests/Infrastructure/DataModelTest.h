//
//  Created by jansabbe on 30/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSPersistentStore;
@class NSManagedObjectContext;


@interface DataModelTest : SenTestCase
@property(nonatomic, strong) NSManagedObjectModel *model;
@property(nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property(nonatomic, strong) NSPersistentStore *store;
@property(nonatomic, strong) NSManagedObjectContext *context;
@end