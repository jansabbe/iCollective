//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ICPerson.h"


@implementation ICPerson
@synthesize username = _username;
@synthesize fullName = _fullName;
@synthesize mobilePhone = _mobilePhone;
@synthesize workPhone = _workPhone;
@synthesize personId = _personId;
@synthesize email = _email;
@synthesize personalHomepage = _personalHomepage;
@synthesize homePhone = _homePhone;
@synthesize twitter = _twitter;


+ (ICPerson *)personInContext:(NSManagedObjectContext *)managedObjectContext {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
}

@end