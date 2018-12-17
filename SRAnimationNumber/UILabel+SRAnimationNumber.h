//
//  UILabel+SRAnimationNumber.h
//  SRAnimationNumberDemo
//
//  Created by https://github.com/guowilling on 2018/2/26.
//  Copyright © 2018年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRAnimationNumberEngine.h"

@interface UILabel (SRAnimationNumber)

#pragma mark - Text

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
                        format:(TextFormatBlock)format;

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
                        format:(TextFormatBlock)format
                    completion:(CompletionBlock)completion;

#pragma mark - Attributed Text

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
              attributedFormat:(AttributedTextFormatBlock)attributedFormat;

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
              attributedFormat:(AttributedTextFormatBlock)attributedFormat
                    completion:(CompletionBlock)completion;

@end

