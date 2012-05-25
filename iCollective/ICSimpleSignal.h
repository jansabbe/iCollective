//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface ICSimpleSignal : NSObject
@property(nonatomic, copy) NSString *body;
@property(nonatomic, copy) NSString *senderName;
@property(nonatomic, copy) NSString *timestamp;
@property(nonatomic, copy) NSString *userId;

- (NSString *)senderPhotoUrl;

- (NSString *)bodyAsPlainText;
@end