//
//  ICGroup.m
//  iCollective
//
//  Created by Jan Sabbe on 4/09/12.
//
//

#import "ICGroup.h"

@implementation ICGroup
@dynamic groupId;
@dynamic groupDescription;
@dynamic name;
@dynamic signals;


+ (ICGroup *)groupInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:context];
}

- (NSString *)groupPicUrl {
    return [NSString stringWithFormat:@"/groups/%@/photo/medium", self.groupId];
}

@end
