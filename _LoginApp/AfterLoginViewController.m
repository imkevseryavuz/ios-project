//
//  AfterLoginViewController.m
//  _LoginApp
//
//  Created by STU 43 on 03/09/38 AH.
//  Copyright (c) 1438 AH STU 26. All rights reserved.
//

#import "AfterLoginViewController.h"

@interface AfterLoginViewController ()
@end

@implementation AfterLoginViewController
-(void) setText:(NSString *)paramText{
    self.title=paramText;
    	
}


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

@end
