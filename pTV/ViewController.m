//
//  ViewController.m
//  pTV
//
//  Created by Alberto Pasca on 21/04/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

#import "ViewController.h"

#import <VKVideoPlayer/VKVideoPlayer.h>
#import <VKVideoPlayer/VKVideoPlayerViewController.h>
#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>

#import "APM3UParser.h"
#import "APNetwork.h"


// https://dl.dropboxusercontent.com/u/11796049/piStream/tv-ita.m3u


@interface ViewController () <MCSwipeTableViewCellDelegate>
{
    NSArray *_tableData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self statusBar].backgroundColor = [self colorWithHexStringNew:@"#0080FF"];

    self.title = @"ipTV - ita : 0.1";
    self.navigationController.hidesBarsOnSwipe = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    APNetwork *net = [[APNetwork alloc] init];
    [net getPlaylistWithCompletionHandler:^(NSURL *filePath, NSError *error) {
        _tableData = [self getChannels:filePath];
        [self.tableView reloadData];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self statusBar].backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self statusBar].backgroundColor = [self colorWithHexStringNew:@"#0080FF"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIView*) statusBar {
    return [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
}

- (UIColor *) colorWithHexStringNew:(NSString *)str {
    str = [str stringByReplacingOccurrencesOfString:@"#" withString:@""];
    str = [NSString stringWithFormat:@"0x%@", str];
    const char * cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr, NULL, 16);
    return [UIColor colorWithRed: ((float) ((x & 0xFF0000) >> 16)) / 255.0 green: ((float) ((x & 0xFF00) >> 8)) / 255.0 blue: ((float) (x & 0xFF)) / 255.0 alpha: 1.0];
}

- (NSArray*) getChannels:(NSURL*)fUrl {
    APM3UParser *parser = [[APM3UParser alloc] init];
    [parser setUrl:fUrl];
    [parser parse];
    return parser.data;
}


// +---------------------------------------------------------------------------+
#pragma mark - UITableView
// +---------------------------------------------------------------------------+


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idx" forIndexPath:indexPath];

    APM3UModel *model = (APM3UModel*)[_tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.url;

    cell.imageView.image = [UIImage imageNamed:@"ic_tv_48pt"];

    CGSize itemSize = CGSizeMake(20, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();


    UIView *crossView = [self viewWithImageName:@"cross"];
    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeSwitch state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {

    }];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    APM3UModel *model = (APM3UModel*)[_tableData objectAtIndex:indexPath.row];

    VKVideoPlayerViewController *viewController = [[VKVideoPlayerViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
    [viewController playVideoWithStreamURL:[NSURL URLWithString:model.url]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}


// +---------------------------------------------------------------------------+
#pragma mark - MCSwipeTableViewCellDelegate
// +---------------------------------------------------------------------------+


- (void)swipeTableViewCellDidEndSwiping:(MCSwipeTableViewCell *)cell {

}


@end





