//
//  SRAnimationNumberEngine.h
//  SRAnimationNumberDemo
//
//  Created by https://github.com/guowilling on 2018/2/26.
//  Copyright © 2018年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshBlock)(CGFloat currentNumber);
typedef void (^CompletionBlock)(CGFloat endNumber);

typedef NSString *(^TextFormatBlock)(CGFloat currentNumber);
typedef NSAttributedString *(^AttributedTextFormatBlock)(CGFloat currentNumber);

typedef NS_ENUM(NSUInteger, SRAnimationNumberCurve) {
    SRAnimationNumberCurveEaseInOut,
    SRAnimationNumberCurveEaseIn,
    SRAnimationNumberCurveEaseOut,
    SRAnimationNumberCurveLinear
};

@interface SRAnimationNumberEngine : NSObject

+ (instancetype)animationNumberEngine;

- (void)fromNumber:(CGFloat)startNumber
          toNumber:(CGFloat)endNumber
          duration:(CFTimeInterval)duration
             curve:(SRAnimationNumberCurve)curve
           refresh:(RefreshBlock)refresh
        completion:(CompletionBlock)completion;

@end
