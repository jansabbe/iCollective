#import "ICLoginViewController.h"
#import "ICUser.h"


@implementation ICLoginViewController

@synthesize errorMessageLabel = _errorMessageLabel;
@synthesize loginButton = _loginButton;
@synthesize loginTextField = _loginTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize loginActivityIndicator = _loginActivityIndicator;
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.loginTextField.text = [[ICUser currentUser] userName];
    self.passwordTextField.text = [[ICUser currentUser] password];
    [self.loginTextField becomeFirstResponder];
}

- (IBAction)login {
    [self updateGuiStartedLogin];

    [[ICUser currentUser] setUsername:self.loginTextField.text andPassword:self.passwordTextField.text];

    [[ICUser currentUser] configureRestKitAndRunIfUserCanLogin:^void() {
        [self updateGuiEndedLogin];
        [self.delegate loginViewControllerDidCorrectlyLogin:self];
    } ifUserCannotLogin:^void() {
        [self updateGuiEndedLogin];
        [self.loginTextField becomeFirstResponder];
        self.errorMessageLabel.hidden = NO;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.loginTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.passwordTextField resignFirstResponder];
        [self login];
    }
    return YES;
}

- (void)updateGuiStartedLogin {
    [self.loginActivityIndicator startAnimating];
    self.errorMessageLabel.hidden = YES;
    self.loginButton.enabled = NO;
}

- (void)updateGuiEndedLogin {
    [self.loginActivityIndicator stopAnimating];
    self.loginButton.enabled = YES;
}

- (void)viewDidUnload {
    [self setErrorMessageLabel:nil];
    [super viewDidUnload];
}
@end