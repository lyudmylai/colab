//
//  JETSignInForm
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETSignInFormViewController.h"
#import "JETSignInFormView.h"
#import "JETAppDelegate.h"

@interface JETSignInFormViewController ()

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) JETSignInFormView *signInView;

@end

@implementation JETSignInFormViewController

static NSString *const kViewControllerName = @"Sign In";
static NSString *const kEndPointUrlKey = @"endPointUrl";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInView = [[JETSignInFormView alloc]initWithFrame:self.view.frame];
    [self.signInView.loginButton addTarget:self
                                    action:@selector(onLoginButtonTapped:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.signInView.signUpButton addTarget:self
                                     action:@selector(onSignUpButtonTapped:)
                           forControlEvents:UIControlEventTouchUpInside];
    self.view = self.signInView;
    [self setTitle:kViewControllerName];
}

- (void)onSignUpButtonTapped:(id)sender {
    NSString *endPointUrl = [[NSUserDefaults standardUserDefaults]valueForKey:kEndPointUrlKey];
    NSDictionary *parameters = @{
                                 @"format":@"json",
                                 @"username":self.signInView.usernameTextfield.text,
                                 @"password":self.signInView.passwordTextfield.text,
                                 };
    NSString *boundary = @"---------------------8457349857---";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endPointUrl]];
    [request setHTTPMethod:@"POST"];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];

    NSMutableData *httpBody = [NSMutableData data];

    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];

    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary]
                              dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",
                               parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue]
                              dataUsingEncoding:NSUTF8StringEncoding]];
    }];

    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *sentPayload = [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
    NSLog(@"%@", sentPayload);
    NSURLSessionUploadTask *task =
    [urlSession uploadTaskWithRequest:request
                             fromData:httpBody
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        if (error) {
                            NSLog(@"Cannot send Login data");
                            return;
                        }
                        NSString *receivedDataString = [[NSString alloc] initWithData:data
                                                                             encoding:NSUTF8StringEncoding];
                        NSLog(@"Success, %@", receivedDataString);
                        return;
                    }
     ];
    [self loadHomePage];
    [task resume];
}

- (void)onLoginButtonTapped:(id)sender {
    NSString *endPointUrl = [[NSUserDefaults standardUserDefaults]valueForKey:kEndPointUrlKey];
    NSDictionary *parameters = @{
                                 @"format":@"json",
                                 @"username":self.signInView.usernameTextfield.text,
                                 @"password":self.signInView.passwordTextfield.text,
                                 };
    NSString *boundary = @"---------------------8457349857---";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:endPointUrl]];
    [request setHTTPMethod:@"POST"];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];

    NSMutableData *httpBody = [NSMutableData data];

    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];

    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary]
                              dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",
                               parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue]
                              dataUsingEncoding:NSUTF8StringEncoding]];
    }];

    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *sentPayload = [[NSString alloc] initWithData:httpBody encoding:NSUTF8StringEncoding];
    NSLog(@"%@", sentPayload);
    NSURLSessionUploadTask *task =
    [urlSession uploadTaskWithRequest:request
                             fromData:httpBody
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        if (error) {
                            NSLog(@"Cannot send Login data");
                            return;
                        }
                        NSString *receivedDataString = [[NSString alloc] initWithData:data
                                                                             encoding:NSUTF8StringEncoding];
                        NSLog(@"Success, %@", receivedDataString);
                        return;
                    }
     ];
    [self loadHomePage];
    [task resume];
}

- (void)loadHomePage {
    JETAppDelegate *appDelegate = (JETAppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate loadHomePage];
}

@end
