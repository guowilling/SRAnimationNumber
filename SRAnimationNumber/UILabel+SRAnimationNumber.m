//
//  UILabel+SRAnimationNumber.m
//  SRAnimationNumberDemo
//
//  Created by https://github.com/guowilling on 2018/2/26.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "UILabel+SRAnimationNumber.h"

@implementation UILabel (SRAnimationNumber)

#pragma mark - Text

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
                        format:(TextFormatBlock)format
{
    [self sr_animationFromNumber:numberA toNumber:numberB duration:duration curve:curve format:format completion:nil];
}

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
                        format:(TextFormatBlock)format
                    completion:(CompletionBlock)completion
{
    [[SRAnimationNumberEngine animationNumberEngine] fromNumber:numberA toNumber:numberB duration:duration curve:curve refresh:^(CGFloat currentNumber) {
        if (format) {
            self.text = format(currentNumber);
        } else {
            self.text = [NSString stringWithFormat:@"%.2f", currentNumber];
        }
    } completion:completion];
}

#pragma mark - Attributed Text

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
              attributedFormat:(AttributedTextFormatBlock)attributedFormat
{
    [self sr_animationFromNumber:numberA toNumber:numberB duration:duration curve:curve attributedFormat:attributedFormat completion:nil];
}

- (void)sr_animationFromNumber:(CGFloat)numberA
                      toNumber:(CGFloat)numberB
                      duration:(CFTimeInterval)duration
                         curve:(SRAnimationNumberCurve)curve
              attributedFormat:(AttributedTextFormatBlock)attributedFormat
                    completion:(CompletionBlock)completion {
    [[SRAnimationNumberEngine animationNumberEngine] fromNumber:numberA toNumber:numberB duration:duration curve:curve refresh:^(CGFloat currentNumber) {
        if (attributedFormat) {
            self.attributedText = attributedFormat(currentNumber);
        } else {
            self.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", currentNumber]];
        }
    } completion:completion];
}

@end
