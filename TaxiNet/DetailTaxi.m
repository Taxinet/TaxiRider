//
//  DetailTaxi.m
//  taxinet
//
//  Created by Louis Nhat on 3/31/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "DetailTaxi.h"

@interface DetailTaxi ()

@end

@implementation DetailTaxi

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imagedriver.layer.masksToBounds = YES;
    self.imagedriver.layer.cornerRadius = self.imagedriver.frame.size.height/2;

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

- (IBAction)Book:(id)sender {
   
}

- (IBAction)cancel:(id)sender {
    [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
    }];
}
@end
