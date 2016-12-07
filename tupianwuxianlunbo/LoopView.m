//
//  LoopView.m
//  tupianwuxianlunbo
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoopView.h"
#import "LoopViewLayout.h"
#import "LoopViewCell.h"
#import "WeakTimerTargetObject.h"

@interface LoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) NSTimer *timer;
/**
 图片数组
 */
@property (nonatomic, strong) NSArray *URLStrs;
@end
@implementation LoopView

-(instancetype)initWihtURLStrs:(NSArray *)URLStrs titles:(NSArray *)titles
{
    //调用父控件
    if (self = [super init]) {
        //创建CollectionView
        //collectionViewLayout布局参数
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[LoopViewLayout alloc] init]];
        //设置背景
        collectionView.backgroundColor = [UIColor orangeColor];

        //注册一个cell
        [collectionView registerClass:[LoopViewCell class] forCellWithReuseIdentifier:@"cell"];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        //将collectionView加到当前控制器上
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        //记录数组
        self.URLStrs = URLStrs;
        //在主线程空闲时候执行block里面的代码
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.URLStrs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
       //添加定时器，每隔1秒切换下一张图片
        [self addTimer];
//        NSLog(@"111");

    }
    return self;
}

#pragma mark - UICollectionView 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

//    NSLog(@"222");
    return self.URLStrs.count * 3;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //从缓存池获得cell
    LoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor =  [UIColor colorWithRed:(arc4random() % 256 / 255.0 ) green:(arc4random() % 256 / 255.0 ) blue:(arc4random() % 256 / 255.0 ) alpha:1];
    //传递URL字符串
    // item > 3 4
    cell.URLStr = self.URLStrs[indexPath.item % self.URLStrs.count];
//    NSLog(@"333");
    return cell;
}

#pragma mark - 定时器方法

/**
 添加定时器方法

 */
-(void)addTimer
{
    //创建定时器
    if (self.timer) return;
    
    self.timer = [WeakTimerTargetObject scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


/**
 移除定时器

 */
-(void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;

}

/**
 定时器回调方法

 */
-(void)nextImage
{
//    NSLog(@"%s",__FUNCTION__);
    //获得偏移量
    CGFloat offsetX = self.collectionView.contentOffset.x;
    //计算当前显示的页号
    NSInteger page = offsetX / self.collectionView.bounds.size.width;

    //设置偏移量
    [self.collectionView setContentOffset:CGPointMake((page + 1) * self.collectionView.frame.size.width, 0) animated:YES];
}
#pragma mark - UICollectionViewDelegate  代理方法

/**
 当用户开始拖拽时调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self removeTimer];


}

/**
 当用户停止拖拽的时候

 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    [self scrollViewDidEndDecelerating:scrollView];

}



/**
 当滚动减速时调用

 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    //获得偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    //计算当前显示的页号
    NSInteger page = offsetX / scrollView.bounds.size.width;
    
    if (page == 0) {//滚动到第0张位置
        page = self.URLStrs.count;
        self.collectionView.contentOffset = CGPointMake(page * self.collectionView.frame.size.width, 0);
    }else if (page == [self.collectionView numberOfItemsInSection:0]-1)//滚动到最后一张
    {
    
        page = self.URLStrs.count - 1;
        self.collectionView.contentOffset = CGPointMake(page * self.collectionView.frame.size.width, 0);

    }
    
    NSLog(@"page = %zd",page);
    [self addTimer];

//    NSLog(@"%s",__FUNCTION__);

}

-(void)layoutSubviews{

    [super layoutSubviews];
    //设置frame
    self.collectionView.frame = self.bounds;
}


/**
 对象被销毁的时候调用
 */
-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}
@end
