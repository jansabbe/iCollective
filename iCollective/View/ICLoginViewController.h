#import <Foundation/Foundation.h>


@protocol ICLoginViewControllerDelegate;

@interface ICLoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property(weak, nonatomic) IBOutlet UIButton *loginButton;
@property(weak, nonatomic) IBOutlet UITextField *loginTextField;
@property(weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property(weak, nonatomic) id<ICLoginViewControllerDelegate> delegate;

- (IBAction)login;
@end

@protocol ICLoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewControllerDidCorrectlyLogin:(ICLoginViewController *)controller;

@end