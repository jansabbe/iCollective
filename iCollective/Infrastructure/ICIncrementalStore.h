#import <Foundation/Foundation.h>
#import <AFIncrementalStore/AFIncrementalStore.h>

@class ICSocialTextAPI;


@interface ICIncrementalStore : AFIncrementalStore
@property(nonatomic, strong) ICSocialTextAPI *socialTextAPI;
@end