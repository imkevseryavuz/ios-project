//
//  ProductsByCategoryViewController.m
//  _LoginApp
//
//  Created by STU 26 on 5/16/17.
//  Copyright (c) 2017 STU 26. All rights reserved.
//

#import "ProductsByCategoryViewController.h"

@interface ProductsByCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblCategory;
@property (strong,nonatomic) NSString *categoryName;
@property (strong, nonatomic) IBOutlet UITableView *productsTableView;
@property (nonatomic,strong) NSMutableArray *products;
@end
static NSString *cellIdentifier=@"CellIdentifier";
@implementation ProductsByCategoryViewController
-(void) setText:(NSString *)paramText{
    self.title=paramText;
    self.categoryName=paramText;
}

-(NSMutableArray *) getProductsData{
    
    NSString *urlString=[NSString stringWithFormat:@"http://kevser.etikbiri.net/FilmService.svc/genrefind?turbyfilm=%@",self.categoryName];
    
    NSString *webUrlStr=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:webUrlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    self.products=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    return self.products;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productsTableView.dataSource=self;
    self.productsTableView.delegate=self;
    [self.productsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getProductsData].count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[self.products valueForKeyPath:@"MovieName"][indexPath.row]];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
