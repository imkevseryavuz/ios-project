//
//  ViewController.m
//  _LoginApp
//
//  Created by STU 26 on 5/16/17.
//  Copyright (c) 2017 STU 26. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "AfterLoginViewController.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@end

@implementation ViewController

-(NSString *) login:(NSString *) username:(NSString *) password{
    NSString *urlString=[NSString stringWithFormat:@"http://kevser.etikbiri.net/MusteriService.svc/musteriLogin?username=%@&password=%@",username,password];    
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *returnData=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return returnData;
}


-(void) displayTextIsRequired{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Lütfen kulanıcı adı ve şifre giriniz!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

-(void) userNotExists{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Kullanıcı bulunamadı!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

-(void) errorOccured{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Hata oluştu!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"AfterLoginViewController"]) {
        AfterLoginViewController *afterlogin=segue.destinationViewController;
        [afterlogin setText:self.txtUsername.text];
    }
}


-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"AfterLoginViewController"]) {
        if ([self.txtPassword.text length]==0 || [self.txtUsername.text length]==0) {
            [self displayTextIsRequired];
            return NO;
        }else{
            NSString *returnData=[self login:self.txtUsername.text :self.txtPassword.text];
            NSLog(@"%@",returnData);
            if ([returnData isEqualToString:@"1"]) {
                return YES;
            }else if ([returnData isEqualToString:@"0"]){
                [self userNotExists];
                return NO;
            }else if([returnData isEqualToString:@"-1"]){
                [self errorOccured];
                return NO;
            }
        }
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
