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

- (NSString *)groupPicUrl {
    return [NSString stringWithFormat:@"/groups/%@/photo/medium", self.groupId];
}

@end
