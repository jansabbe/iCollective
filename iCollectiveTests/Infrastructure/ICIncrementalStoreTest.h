#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

@class ICStubCoreDataContext;
@class ICUser;


@interface ICIncrementalStoreTest : SenTestCase
@property (nonatomic) ICStubCoreDataContext *context;

@property(nonatomic, strong) ICUser *user;
@end