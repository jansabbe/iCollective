#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

@class ICSocialTextAPI;
@class NSManagedObjectContext;
@class ICStubCoreDataContext;


@interface ICSocialTextAPITest : SenTestCase
@property (nonatomic) ICSocialTextAPI*socialTextClient;
@property (nonatomic) ICStubCoreDataContext *coreDataContext;

@end