//
//  SatisViewController.m
//  _LoginApp
//
//  Created by STU 26 on 5/31/17.
//  Copyright (c) 2017 STU 26. All rights reserved.
//

#import "SatisViewController.h"

@interface SatisViewController ()

@end

@implementation SatisViewController

-(void) btnSendClicked:(UIButton *)sender{
    NSString *urlString=[NSString stringWithFormat:@"http://kevser.etikbiri.net/BiletSatisService.svc/biletsatisEkle?customerPhone=%@&totalTicket=%@&movieId=%@&dateofPurchase=%@",self.txtNo.text,self.txtAdet.text,self.txtAdi.text,self.txtTarih.text];
    
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0f];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *body=[[NSString alloc] initWithFormat:@"customerPhone=%@&totalTicket=%@&movieId=%@&dateofPurchase=%@",self.txtNo.text,self.txtAdet.text,self.txtAdi.text,self.txtTarih.text];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if ([data length]>0 && connectionError==nil) {
            NSString *html=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",html);
        }else if ([data length]==0 && connectionError==nil){
            NSLog(@"No data!");
        }else if (connectionError!=nil){
            NSLog(@"%@",connectionError);
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnSend addTarget:self action:@selector(btnSendClicked:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
