//
//  StudentByNotesViewController.m
//  _LoginApp
//
//  Created by STU 26 on 5/23/17.
//  Copyright (c) 2017 STU 26. All rights reserved.
//

#import "StudentByNotesViewController.h"

@interface StudentByNotesViewController ()

@end

@implementation StudentByNotesViewController
-(void) setText:(NSString *)paramText{
    self.title=paramText;
}

-(void) btnGetClicked: (UIButton * ) sender {
    
    NSString *urlString=[[NSString alloc] initWithFormat :@"http://kevser.etikbiri.net/FilmService.svc/filmbul?filmadi=%@",self.txtId.text];
    NSURL *url=[NSURL URLWithString:urlString];
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0f];
    
    [request setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if ([data length]>0 && connectionError==nil) {
            
            NSData * jsonData =[NSData dataWithContentsOfURL:url];
            NSError * error;
            
            NSMutableArray *jsonArray = [NSJSONSerialization
                                         JSONObjectWithData:jsonData
                                         options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                         error:&error];
            
            self.txtDersAdi.text=[NSString stringWithFormat:@"%@",[jsonArray valueForKey:@"DirectorName"]];
            
            
            self.txtPuan.text=[NSString stringWithFormat:@"%@",[jsonArray valueForKey:@"GenreName"]];
            
            self.txtVisionD.text=[NSString stringWithFormat:@"%@",[jsonArray valueForKey:@"VisionFinishD"]];
            
        }else if ([data length]==0 && connectionError==nil){
            NSLog(@"No data!");
        }else if (connectionError!=nil){
            NSLog(@"%@",connectionError);
        }
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnGet addTarget:self action:@selector(btnGetClicked:) forControlEvents:UIControlEventTouchUpInside];
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
