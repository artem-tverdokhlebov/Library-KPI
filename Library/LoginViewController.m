//
//  LoginViewController.m
//  Library
//
//  Created by Leonid Humeniuk on 12/20/15.
//  Copyright © 2015 Leonid Humeniuk & Artem Tverdokhlebov. All rights reserved.
//

#import "LoginViewController.h"
#import "Library-Swift.h"
#import "ReaderController.h"
#import "ReaderBookController.h"
@interface LoginViewController()
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property (nonatomic) NSArray *data;
@property (nonatomic) int readerID;
@end
@implementation LoginViewController
-(void)viewDidLoad{
    [super viewDidLoad];
}

- (IBAction)loginAction:(id)sender {
  @try{
        self.data =  [DB query:[NSString stringWithFormat:@"SELECT * FROM reader WHERE login = '%@' and password = '%@'",self.loginTextField.text,self.passwordTextField.text]];
        NSDictionary *info = self.data[0];
            Reader *reader = [Reader new];
            [reader parseFromDictionary:info];
                if([reader.login isEqualToString:@"admin"]){
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Librarian" bundle:nil];
                    UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Librarian"];
                    [self presentViewController:myVC animated:YES completion:NULL];
                } else {
                    self.readerID = reader.reader_id;
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Reader" bundle:nil];
                    ReaderController *myVC = (ReaderController *)[storyboard instantiateViewControllerWithIdentifier:@"Reader"];
                    
                    myVC.readerID = self.readerID;
                [self presentViewController:myVC animated:YES completion:NULL];
                    
                }
                
        
    }
    @catch (NSException *ex){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login ERROR"
                                                                       message:@"There is no user with same login or pass"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                  self.loginTextField.text = @"";
                                                                  self.passwordTextField.text = @"";
                                                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        [alert addAction:alertAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
    
}





@end
