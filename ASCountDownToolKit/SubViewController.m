//
//  SubViewController.m
//  ASCountDownToolKit
//
//  Created by haohao on 16/11/2.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "SubViewController.h"
#import "CustomCell.h"
#import "ASCountDownView.h"
@interface SubViewController () <UITableViewDelegate, UITableViewDataSource, CountDownViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [UIView new];
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"2016-11-02 16:53:05", @"2016-11-11 12:10:36", @"2016-11-11 13:50:50", @"2016-11-11 14:34:42", @"2016-11-11 15:33:59", @"2016-11-11 16:54:13", @"2016-11-11 17:19:16", @"2016-11-11 18:23:19", @"2016-11-11 19:29:22", @"2016-11-11 20:36:35", @"2016-11-11 21:38:39",nil];
    }
    return _dataArray;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[ASCountDownView class]]) {
            [view removeFromSuperview];
        }
    }
    ASCountDownView *countDownView = [[ASCountDownView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    countDownView.endTime = self.dataArray[indexPath.row];
    countDownView.delegate = self;
    [cell.contentView addSubview:countDownView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- CountDownViewDelegate
-(void)CountDownViewFinised
{
    NSLog(@"倒计时完毕");
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
