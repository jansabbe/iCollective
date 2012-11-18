//
//  ICSocialTextAPI.m
//  iCollective
//
//  Created by Jan Sabbe on 14/11/12.
//
//

#import "ICSocialTextAPI.h"
#import "ICUser.h"

static NSString *const kICSocialTextBaseURL = @"https://cegeka.socialtext.net/data";

@implementation ICSocialTextAPI

+ (ICSocialTextAPI *)sharedClient {
    static dispatch_once_t dispatchOnce;
    static ICSocialTextAPI *client;

    dispatch_once(&dispatchOnce, ^{
        client = [[ICUser currentUser] socialTextClient];
    });
    return client;
}

+ (ICSocialTextAPI *)clientForUser:(ICUser *)user {
    return [[self alloc] initWithBaseURL:[NSURL URLWithString:kICSocialTextBaseURL] loginAs:user];
}

- (id)initWithBaseURL:(NSURL *)url loginAs:(ICUser *)user {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setAuthorizationHeaderWithUsername:user.userName password:user.password];
    return self;
}

- (NSString *)pathForEntity:(NSEntityDescription *)entity {
    if ([entity.name isEqualToString:@"Person"]) {
        return @"people";
    }
    return [super pathForEntity:entity];
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation ofEntity:(NSEntityDescription *)entity fromResponse:(NSHTTPURLResponse *)response {
    NSMutableDictionary * dictionary = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    if ([entity.name isEqualToString:@"Signal"]) {
        dictionary[@"signalId"] = representation[@"signal_id"];
        dictionary[@"timestamp"] = [self parseDate:representation[@"at"]];
    } else if ([entity.name isEqualToString:@"Group"]) {
        dictionary[@"groupId"] = representation[@"group_id"];
        dictionary[@"groupDescription"] = representation[@"description"];
    } else if ([entity.name isEqualToString:@"Person"]) {
        dictionary[@"personId"] = [representation[@"id"] description];
        dictionary[@"fullName"] = representation[@"best_full_name"];
    }
    return dictionary;
}

- (NSString *)resourceIdentifierForRepresentation:(NSDictionary *)representation ofEntity:(NSEntityDescription *)entity fromResponse:(NSHTTPURLResponse *)response {
    if ([entity.name isEqualToString:@"Signal"]) {
        return representation[@"signal_id"];
    } else if ([entity.name isEqualToString:@"Group"]) {
        return representation[@"group_id"];
    }
    return [super resourceIdentifierForRepresentation:representation ofEntity:entity fromResponse:response];
}

- (NSDictionary *)representationsForRelationshipsFromRepresentation:(NSDictionary *)representation ofEntity:(NSEntityDescription *)entity fromResponse:(NSHTTPURLResponse *)response {
    NSMutableDictionary *dictionary = [[super representationsForRelationshipsFromRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    if ([entity.name isEqualToString:@"Signal"]) {
        dictionary[@"sender"] = @{
            @"id": representation[@"user_id"],
            @"best_full_name": representation[@"best_full_name"]
        };

        if (representation[@"likers"]) {
            NSMutableArray *likerDictionaries = [NSMutableArray array];

            for (NSString *likerId in representation[@"likers"]) {
                [likerDictionaries addObject:@{@"id": likerId}];
            }
            dictionary[@"likers"] = likerDictionaries;
        }

        if (representation[@"in_reply_to"]) {
            dictionary[@"inReplyToSignal"] = @{@"signal_id": [representation valueForKeyPath:@"in_reply_to.signal_id"]};
        }

        if (representation[@"group_ids"] && [representation[@"group_ids"] count] > 0) {
            dictionary[@"group"] = @{ @"group_id": [representation[@"group_ids"] lastObject] };
        }
    }

    return dictionary;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship forObjectWithID:(NSManagedObjectID *)objectID inManagedObjectContext:(NSManagedObjectContext *)context {
    return [relationship.name isEqualToString:@"replies"];
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID inManagedObjectContext:(NSManagedObjectContext *)context {
    return YES;
}

- (NSDate *)parseDate:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSS'Z'"];
    return [formatter dateFromString:date];
}

- (NSMutableURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest withContext:(NSManagedObjectContext *)context {
    NSMutableURLRequest *request = [super requestForFetchRequest:fetchRequest withContext:context];
    NSLog(@"requestForFetchRequest: %@", request);
    return request;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method pathForObjectWithID:(NSManagedObjectID *)objectID withContext:(NSManagedObjectContext *)context {
    NSMutableURLRequest *request = [super requestWithMethod:method pathForObjectWithID:objectID withContext:context];
    NSLog(@"requestForFetchRequest: %@", request);
    return request;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method pathForRelationship:(NSRelationshipDescription *)relationship forObjectWithID:(NSManagedObjectID *)objectID withContext:(NSManagedObjectContext *)context {
    NSMutableURLRequest *request = [super requestWithMethod:method pathForRelationship:relationship forObjectWithID:objectID withContext:context];
    NSLog(@"requestForFetchRequest: %@", request);
    return request;
}

@end
