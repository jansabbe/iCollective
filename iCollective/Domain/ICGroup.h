//
//  ICGroup.h
//  iCollective
//
//  Created by Jan Sabbe on 4/09/12.
//
//

#import <CoreData/CoreData.h>

@interface ICGroup : NSManagedObject
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* groupDescription;
@property (nonatomic,strong) NSNumber* groupId;
@end
