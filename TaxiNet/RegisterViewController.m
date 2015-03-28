//
//  RegisterViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "RegisterViewController.h"
#import "unity.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (IBAction)save:(id)sender {
    [unity register_by_email:@"11629932224d@gmail.com" password:@"123" firstname:@"ha" lastname:@"nhat" phone:@"1234" language:@"vi" usergroup:@"rd" countrycode:@"vn"];
}
@end
