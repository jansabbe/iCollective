//
//  Created by jansabbe on 30/03/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

@class ICStubCoreDataContext;


@interface DataModelTest : SenTestCase
@property (nonatomic) ICStubCoreDataContext *coreDataContext;

@end