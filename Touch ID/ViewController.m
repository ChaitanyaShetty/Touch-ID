//
//  ViewController.m
//  Touch ID
//
//  Created by test on 3/1/17.
//  Copyright © 2017 com.neorays. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)alert :(NSString *)title message:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
 
    LAContext *myContext = [[LAContext alloc]init];
    NSError *err = nil;
    NSString *myLocalizedReasonString = @"Touch ID Test to show Touch ID working in a custom app";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"success" sender:nil];
                });
            } else {
                [self alert:@"error" message:error.description];
            }
        }];
    } else {
        [self alert:@"Error" message:err.description];
    }
}
@end
