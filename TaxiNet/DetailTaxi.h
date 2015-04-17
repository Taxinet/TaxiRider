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

@end
