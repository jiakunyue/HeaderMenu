//
//  HeaderView.m
//  PageViewController
//
//  Created by Justin on 2017/7/19.
//  Copyright © 2017年 jerei. All rights reserved.
//

#import "HeaderView.h"


#define tagIndex 20170720

@interface HeaderView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation HeaderView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
        
        [self setupUI];
    }
    return self;
}

- (void)setMenuArray:(NSMutableArray *)menuArray {
    _menuArray = menuArray;
    
    [self setupMenuButton];
}

- (void)setSelectedBtn:(UIButton *)selectedBtn {
    if (selectedBtn == _selectedBtn) {
        return;
    }
    
    //计算scrollview偏移量
    CGFloat originX = selectedBtn.center.x - CGRectGetMidX(self.scrollView.frame);
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    if (originX < 0) {
        originX = 0;
    }else if (originX > maxOffsetX){
        originX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(originX, 0) animated:YES];
    
    //改变按钮颜色
    [self.selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectedBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    //缩放动画
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = [NSNumber numberWithFloat:1.2f];
    animation1.toValue  = [NSNumber numberWithFloat:1.0f];
    animation1.duration = 0.3;
    animation1.repeatCount = 1;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.autoreverses = NO;
    [self.selectedBtn.titleLabel.layer addAnimation:animation1 forKey:@"animation1"];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:1.0f];
    animation2.toValue  = [NSNumber numberWithFloat:1.2f];
    animation2.duration = 0.3;
    animation2.repeatCount = 1;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    animation2.autoreverses = NO;
    [selectedBtn.titleLabel.layer addAnimation:animation2 forKey:@"animation2"];
    
    _selectedBtn = selectedBtn;
}
#pragma mark - 页面布局
- (void)setupUI {
    
    [self setupScrollView];
    
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    scrollView.backgroundColor = [UIColor colorWithRed:1/255.0 green:116/255.0 blue:219/255.0 alpha:1.f] ;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupMenuButton {
    
    //移除已有按钮
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    UIFont *btnFont = [UIFont systemFontOfSize:16];
    for (NSInteger i = 0; i < self.menuArray.count; i ++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = tagIndex + i;
        [menuBtn setTitle:self.menuArray[i] forState:UIControlStateNormal];
        [menuBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        menuBtn.titleLabel.font = btnFont;
        
        CGFloat menuBtnX = 0.f;
        if (self.scrollView.subviews.count > 0) {
            //非第一个
            menuBtnX = CGRectGetMaxX([self.scrollView.subviews lastObject].frame);
        }
        
//        CGRect btnRect = [self.menuArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : btnFont} context:nil];
        
        CGFloat btnW = 0;
        if (self.menuArray.count > 6) {
            btnW = [UIScreen mainScreen].bounds.size.width / 6;
        } else {
            btnW = [UIScreen mainScreen].bounds.size.width / self.menuArray.count;
        }
        
        menuBtn.frame = CGRectMake(menuBtnX, 0, btnW, self.scrollView.frame.size.height);
        
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:menuBtn];
        
        if (i == 0) {
            //默认第一个选中
            self.selectedBtn = menuBtn;
        }
    }
    
    if (self.scrollView.subviews.count > 0) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([self.scrollView.subviews lastObject].frame), 0);
    }
    
}

- (void)menuBtnClick:(UIButton *)sender {
    if (self.selectedBtn == sender) {
        return;
    }
    self.selectedBtn = sender;
    if ([self.delegate respondsToSelector:@selector(menuBtnClickAtIndex:)]) {
        [self.delegate menuBtnClickAtIndex:sender.tag - tagIndex];
    }
}

- (void)setselectedIndex:(NSInteger)index{
    if ([self.scrollView subviews].count > index) {
        UIButton *selectedBtn = (UIButton *)[self.scrollView subviews][index];
        self.selectedBtn = selectedBtn;
    }
}


@end
