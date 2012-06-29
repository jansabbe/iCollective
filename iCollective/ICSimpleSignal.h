//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface ICSimpleSignal : NSObject
@property(nonatomic, copy) NSNumber *signalId;
@property(nonatomic, copy) NSString *body;
@property(nonatomic, copy) NSString *senderName;
@property(nonatomic, copy) NSDate *timestamp;
@property(nonatomic, copy) NSNumber *senderId;
@property(nonatomic, copy) NSNumber *inReplyToSignalId;
@property(nonatomic, copy) NSArray *personIdsLikingThis;
@property(nonatomic, copy) NSArray *groupIdsPostedTo;

- (NSString *)senderPhotoUrl;

- (NSString *)bodyAsPlainText;
@end
