//
//  Created by jansabbe on 27/04/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ICPerson : NSManagedObject
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *fullName;
@property(nonatomic, strong) NSString *homePhone;
@property(nonatomic, strong) NSString *mobilePhone;
@property(nonatomic, strong) NSString *workPhone;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSNumber *personId;
@property(nonatomic, strong) NSString *personalHomepage;
@property(nonatomic, strong) NSString *twitter;

+ (ICPerson *)personInContext:(NSManagedObjectContext *)managedObjectContext;

@end
