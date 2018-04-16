//
//  CVNavigationController.m
//  CapsuleVoice
//
//  Created by 5i84 on 2017/5/16.
//  Copyright © 2017年 LiJingZe. All rights reserved.
//
#define SCREEN_WIDTH  UIScreen.mainScreen.bounds.size.width

#import "CVNavigationController.h"
#import "CapsuleVoice-Swift.h"

@interface CVNavigationController () <UINavigationControllerDelegate>{
    UIView *_blurBackView;
}

@property (nonatomic, weak) id PopDelegate;

@end

@implementation CVNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor withHexWithHexString:@"59bccd" alpha:1],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    self.navigationBar.tintColor = [UIColor withHexWithHexString:@"59bccd" alpha:1];
    
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

// 拦截所有控制器的push控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //设置barButton
        viewController.navigationItem.leftBarButtonItem = [self itemWithTarget:self
                                                                        action:@selector(popLastView)
                                                                         image:@"nav-back"
                                                                     highImage:@"nav-back"];
    }
    [super pushViewController:viewController animated:animated];
}


- (void)popLastView {
    [self popViewControllerAnimated:YES];
}

// 设置返回barButton
- (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                          highImage:(NSString *)highImage {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = CGSizeMake(30, 30);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

// 颜色转换为背景图片
- (UIImage *)imageWithColor{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.97 alpha:0.97].CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


- (UIView *)blurBackView {
    if (_blurBackView == nil) {
        _blurBackView = [UIView new];
        _blurBackView.frame = CGRectMake(0, -20, SCREEN_WIDTH, 64);
        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        gradientLayer.colors = @[(__bridge id)[UIColor withHexWithHexString:@"040012" alpha:0.76].CGColor,(__bridge id)[UIColor withHexWithHexString:@"040012" alpha:0.28].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1.0);
        [_blurBackView.layer addSublayer:gradientLayer];
        _blurBackView.userInteractionEnabled = NO;
        _blurBackView.alpha = 0.5;
    }
    return _blurBackView;
}


@end
