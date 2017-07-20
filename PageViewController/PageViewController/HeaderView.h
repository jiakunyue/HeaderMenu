//
//  HeaderView.h
//  PageViewController
//
//  Created by Justin on 2017/7/19.
//  Copyright © 2017年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

- (void)menuBtnClickAtIndex:(NSInteger)index;

@end

@interface HeaderView : UIView

@property (nonatomic,weak) id<HeaderViewDelegate> delegate;

@property (nonatomic,strong) NSMutableArray *menuArray;

- (void)setselectedIndex:(NSInteger)index;
@end
