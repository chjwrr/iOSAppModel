//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kSCREEN_WIDTH ,kSCREEN_HEIGHT - kSTATUSBAR_HEIGHT - kNAVIGATIONBAR_HEIGHT - kTABBAR_HEIGHT)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    self.tableView.mj_header=[self addTableViewHeaderRefreshingTarget:self refreshingAction:@selector(refrehData)];
    self.tableView.mj_footer=[self addTableViewFooterRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [_tableView.mj_header beginRefreshing];
    
   
}


-(void)refrehData{
    NSLog(@"refrehData");
    [self headerEndRefresh];
}
-(void)loadMore{
    NSLog(@"loadMore");
    [self footerEndRefresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 44.0f;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellstr =@"UITableViewCell";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellstr];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
