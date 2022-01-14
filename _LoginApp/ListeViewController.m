//
//  ListeViewController.m
//  _LoginApp
//
//  Created by STU 26 on 5/23/17.
//  Copyright (c) 2017 STU 26. All rights reserved.
//

#import "ListeViewController.h"
static NSString *MyCellIdentifier=@"CellIdentifier";
@interface ListeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *allRows;
@property (nonatomic,strong) NSArray *objects;
@end

@implementation ListeViewController
-(void) setText:(NSString *)paramText{
    self.title=paramText;
}


-(NSMutableArray *) allRows{
    NSURL *url=[[NSURL alloc] initWithString:@"http://kevser.etikbiri.net/FilmService.svc/filmJson"];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    NSData *urlData;
    NSURLResponse *response;
    NSError *error=nil;
    urlData=[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSMutableArray *object=[NSJSONSerialization JSONObjectWithData:urlData options:1 error:&error];
    if (_allRows==nil) {
        const NSUInteger numberofItems=[object count];
        _allRows=[[NSMutableArray alloc] initWithCapacity:numberofItems];
        for (NSUInteger counter; counter<numberofItems; counter++) {
            [_allRows addObject:[[NSString alloc] initWithFormat:@"%@",[object[counter] objectForKey:@"MovieName"]]];
            [_allRows addObject:[[NSString alloc] initWithFormat:@"%@",[object[counter] objectForKey:@"DirectorName"]]];
            [_allRows addObject:[[NSString alloc] initWithFormat:@"%@",[object[counter] objectForKey:@"GenreName"]]];
            [_allRows addObject:[[NSString alloc] initWithFormat:@"%@",[object[counter] objectForKey:@"VisionStartD"]]];
            [_allRows addObject:[[NSString alloc] initWithFormat:@"%@",[object[counter] objectForKey:@"VisionFinishD"]]];
            
        }
    }
    return _allRows;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.allRows count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier:MyCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text=self.allRows[indexPath.row];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MyCellIdentifier];
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    self.myTableView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.myTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
