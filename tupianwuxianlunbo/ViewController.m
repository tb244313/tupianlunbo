//
//  ViewController.m
//  tupianwuxianlunbo
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LoopView.h"
@interface ViewController ()
@property (nonatomic, weak) LoopView *loopView;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
/**
 加载数据
 */
-(void)loadData
{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://c.m.163.com/nc/ad/headline/0-3.html"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        //回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //将二进制数据转成字典
            NSDictionary *result =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //获得新闻数组
            NSArray *news = result[@"headline_ad"];
            //获得图片数组字符串
            NSArray *URLStrs = [news valueForKeyPath:@"imgsrc"];
            //获得标题数组
            NSArray *titles = [news valueForKeyPath:@"title"];
            //创建图片轮播器
            LoopView *loopView = [[LoopView alloc] initWihtURLStrs:URLStrs titles:titles];
            //设置尺寸
            loopView.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
            loopView.backgroundColor = [UIColor redColor];
            //将图片轮播器添加到控制器的view上
            [self.view addSubview:loopView];
            self.loopView = loopView;
//            NSLog(@"%@",news);
        }];
    }] resume];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.loopView removeFromSuperview];
    self.loopView = nil;
}
@end

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
/*
 开发步骤
 1.加载数据
 2.搭建界面：UICollectionView + UILabel + UIPageControl
 
 */

