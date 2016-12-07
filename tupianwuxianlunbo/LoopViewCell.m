//
//  LoopViewCell.m
//  tupianwuxianlunbo
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoopViewCell.h"
#import "UIImageView+WebCache.h"


@interface LoopViewCell ()
@property (nonatomic, weak) UIImageView *iconView;


@end
@implementation LoopViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //创建图片
        UIImageView *iconView = [[UIImageView alloc] init];
        //讲图片添加到当前cell、
        [self addSubview:iconView];
        self.iconView = iconView;
    }
    return self;
}


-(void)setURLStr:(NSString *)URLStr
{
    _URLStr = URLStr;
    //下载图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:URLStr]];

}
-(void)layoutSubviews{

    [super layoutSubviews];
    self.iconView.frame = self.bounds;

}
@end
