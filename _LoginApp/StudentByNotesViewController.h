//
//  StudentByNotesViewController.h
//  _LoginApp
//
//  Created by STU 26 on 5/23/17.
//  Copyright (c) 2017 STU 26. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentByNotesViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtId;
@property (strong, nonatomic) IBOutlet UITextField *txtDersAdi;
@property (strong, nonatomic) IBOutlet UITextField *txtPuan;
@property (strong, nonatomic) IBOutlet UITextField *txtVisionD;
@property (strong, nonatomic) IBOutlet UIButton *btnGet;
-(void) setText:(NSString *) paramText;
@end
