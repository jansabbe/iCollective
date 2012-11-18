//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICPerson.h"


@implementation ICPerson
@dynamic username;
@dynamic homePhone;
@dynamic workPhone;
@dynamic mobilePhone;
@dynamic fullName;
@dynamic email;
@dynamic personId;
@dynamic personalHomepage;
@dynamic twitter;
@dynamic liked;

+ (ICPerson *)personInContext:(NSManagedObjectContext *)managedObjectContext {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
}

- (NSString *)firstLetterOfName {
    [self willAccessValueForKey:@"firstLetterOfName"];
    NSString *result = [self.fullNameInUppercase substringToIndex:1];
    [self didAccessValueForKey:@"firstLetterOfName"];
    return result;
}

- (NSString *)fullNameInUppercase {
    return [self.fullName uppercaseString];
}


- (NSString *)photoUrl {
    return [NSString stringWithFormat:@"/people/%@/photo/medium", self.personId];
}


@end