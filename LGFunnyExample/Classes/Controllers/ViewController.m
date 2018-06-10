//
//  ViewController.m
//  LGFunnyExample
//
//  Created by 李刚 on 2018/6/10.
//  Copyright © 2018年 LiGang. All rights reserved.
//

#import "ViewController.h"
#import "CLTableView.h"
#import "CLCellModel.h"
#import "CLTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "AFNetworking.h"
#import <YYModel/YYModel.h>
#import "CLTableViewModel.h"
#import "MJRefresh.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) CLTableView *tableView;

@property (nonatomic, copy) NSString *tableViewTitleStr;

@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark -Life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    [self fetchDatas];
    [self initSubviews];
}

#pragma mark -Pravite

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)fetchDatas {
    NSString *urlStr = @"http://thoughtworks-ios.herokuapp.com/facts.json";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            CLTableViewModel *model = [CLTableViewModel yy_modelWithJSON:responseObject];
            self.tableViewTitleStr = model.titleStr;
            self.dataArray = model.cellDataArray;
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    }];
    [dataTask resume];
    
}

- (void)initSubviews {
    self.tableView = [[CLTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchDatas];
    }];
    [self.tableView registerClass:[CLTableViewCell class] forCellReuseIdentifier:@"identifer"];
    [self.view addSubview:self.tableView];
}

#pragma mark -UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CLTableViewCell *cell = [[CLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CLCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell bindWithModel:model];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.tableViewTitleStr;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"identifer" cacheByIndexPath:indexPath configuration:^(id cell) {
        CLCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [cell bindWithModel:model];
    }];
}

@end
