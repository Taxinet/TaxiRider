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
bool checked=NO;

- (void)viewDidLoad {
    [super viewDidLoad];
  _checkBox.backgroundColor=[UIColor blueColor];

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
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ( [self.NameUser.text isEqualToString:@""])
    {
        
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"please input username",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else
        if([self.EmailUser.text isEqualToString:@""]||self.EmailUser.text==nil)
        {
            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                             message:NSLocalizedString(@"please input email",nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                   otherButtonTitles:nil, nil];
            [alertTmp show];
            
            
            
        }
        else if ([emailTest evaluateWithObject:self.EmailUser.text] == NO)
        {
            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                             message:NSLocalizedString(@"please input corect email",nil)
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                   otherButtonTitles:nil, nil];
            [alertTmp show];
        }
        else
            if( [self.PassUser.text isEqualToString:@""]|| self.PassUser.text==nil)
            {
                UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                 message:NSLocalizedString(@"please input password",nil)
                                                                delegate:self
                                                       cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                       otherButtonTitles:nil, nil];
                [alertTmp show];
            }
            else
            {
                if (![self.PassUser.text isEqualToString:self.RepassUser.text]) {
                    UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                     message:NSLocalizedString(@"password not right",nil)
                                                                    delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                           otherButtonTitles:nil, nil];
                    [alertTmp show];
                }
                else
                {
                    if (checked==NO) {
                        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                         message:NSLocalizedString(@"tick checkbox",nil)
                                                                        delegate:self
                                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                               otherButtonTitles:nil, nil];
                        [alertTmp show];
                    }
                    else
                    {
                        if( [self.PhoneUser.text isEqualToString:@""]|| self.PhoneUser.text==nil)
                        {
                            UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                                             message:NSLocalizedString(@"please input Phonenumber",nil)
                                                                            delegate:self
                                                                   cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                                   otherButtonTitles:nil, nil];
                            [alertTmp show];
                        }
                        else
                        {
                            [unity register_by_email:self.EmailUser.text password:self.PassUser.text firstname:@" " lastname:self.NameUser.text phone:self.PhoneUser.text language:@"vi" usergroup:@"rd" countrycode:@"vn"];
                        }
                    }
                }
                
            }
    
    
    
}
- (IBAction)checkRule:(id)sender {
    if (!checked) {
        _checkBox.backgroundColor=[UIColor redColor];
        UIImage *btnImage = [UIImage imageNamed:@"checkBox.png"];
        [_checkBox setImage:btnImage forState:UIControlStateNormal];
        checked=YES;
        
    }
    else
    {
        UIImage *btnImage = [UIImage imageNamed:@"checkbox_non.png"];
        [_checkBox setImage:btnImage forState:UIControlStateNormal];
        checked=NO;
    }
}
@end
