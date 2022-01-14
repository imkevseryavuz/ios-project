//
//  HomeViewController.m
//  _LoginApp
//
//  Created by STU 26 on 5/16/17.
//  Copyright (c) 2017 STU 26. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductsByCategoryViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *categoriesTableView;
@property (nonatomic,strong) NSMutableArray *categories;
@property (nonatomic,strong) NSString *categoryName;
@end

static NSString *cellIdentifier=@"CellIdentifier";

@implementation HomeViewController



-(void) setText:(NSString *)paramText{
    self.title=paramText;
}

-(NSMutableArray *) getCategoriesData{
    
    NSString *urlString=@"http://kevser.etikbiri.net/TurService.svc/turlerJson";
    
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    self.categories=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    return self.categories;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getCategoriesData].count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[self.categories valueForKeyPath:@"GenreName"][indexPath.row]];
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.categoriesTableView.dataSource=self;
    self.categoriesTableView.delegate=self;
    [self.categoriesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    self.categoryName=cell.textLabel.text;
    
    [self performSegueWithIdentifier:@"pushProductsByCategoryViewController" sender:self];
}


-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"pushProductsByCategoryViewController"]) {
        return YES;
    }
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"pushProductsByCategoryViewController"]) {
        
        ProductsByCategoryViewController *nextController=segue.destinationViewController;
        
        [nextController setText:self.categoryName];
    }
}


@end
