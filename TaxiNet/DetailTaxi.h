//
//  DetailTaxi.h
//  taxinet
//
//  Created by Louis Nhat on 3/31/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CWPopup.h"

@interface DetailTaxi : UIViewController
- (IBAction)Book:(id)sender;

- (IBAction)cancel:(id)sender;
@property (nonatomic, retain) UIViewController *vcParent;
@property (weak, nonatomic) IBOutlet UILabel *taxiname;
@property (weak, nonatomic) IBOutlet UILabel *taxiBKS;
@property (weak, nonatomic) IBOutlet UILabel *taxisheet;
@property (weak, nonatomic) IBOutlet UILabel *namedriver;
@property (weak, nonatomic) IBOutlet UIImageView *imagedriver;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *to;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end
