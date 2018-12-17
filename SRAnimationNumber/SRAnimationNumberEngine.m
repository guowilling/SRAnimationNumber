//
//  SRAnimationNumberEngine.m
//  SRAnimationNumberDemo
//
//  Created by https://github.com/guowilling on 2018/2/26.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "SRAnimationNumberEngine.h"

typedef CGFloat (*AnimationFunctionCurve)(CGFloat);

@interface SRAnimationNumberEngine ()

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, assign) CGFloat startNumber;
@property (nonatomic, assign) CGFloat endNumber;

@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval lastTime;
@property (nonatomic, assign) CFTimeInterval progressTime;

@property (nonatomic, copy) RefreshBlock refresh;
@property (nonatomic, copy) CompletionBlock completion;

@property AnimationFunctionCurve animationFunctionCurve;

@end

@implementation SRAnimationNumberEngine

+ (instancetype)animationNumberEngine {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _animationFunctionCurve = AnimationFunctionCurveEaseInOut;
    }
    return self;
}

- (void)fromNumber:(CGFloat)startNumber
          toNumber:(CGFloat)endNumber
          duration:(CFTimeInterval)duration
             curve:(SRAnimationNumberCurve)curve
           refresh:(RefreshBlock)refresh
        completion:(CompletionBlock)completion
{
    [self stopTimer];
    
    if (startNumber == endNumber) {
        if (refresh) {
            refresh(endNumber);
        }
        if (completion) {
            completion(endNumber);
        }
        return;
    }
    
    _startNumber = startNumber;
    _endNumber = endNumber;
    
    _duration = duration;
    
    _refresh = refresh;
    _completion = completion;
    
    switch (curve) {
        case SRAnimationNumberCurveEaseInOut:
            _animationFunctionCurve = AnimationFunctionCurveEaseInOut;
            break;
        case SRAnimationNumberCurveEaseIn:
            _animationFunctionCurve = AnimationFunctionCurveEaseIn;
            break;
        case SRAnimationNumberCurveEaseOut:
            _animationFunctionCurve = AnimationFunctionCurveEaseOut;
            break;
        case SRAnimationNumberCurveLinear:
            _animationFunctionCurve = AnimationFunctionCurveLinear;
            break;
    }
    [self startTimer];
}

- (void)startTimer {
    if (_timer) {
        [self stopTimer];
    }
    _lastTime = CACurrentMediaTime();
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshNumber)];
    _timer.frameInterval = 2;
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)refreshNumber {
    CFTimeInterval currentTime = CACurrentMediaTime();
    _progressTime = _progressTime + (currentTime - _lastTime);
    if (_progressTime >= _duration) {
        [self stopTimer];
        if (_refresh) {
            _refresh(_endNumber);
        }
        if (_completion) {
            _completion(_endNumber);
        }
    } else {
        if (_refresh) {
            CGFloat percent = _progressTime / _duration;
            CGFloat currentNumber = _startNumber + (_animationFunctionCurve(percent) * (_endNumber - _startNumber));
            _refresh(currentNumber);
        }
        _lastTime = currentTime;
    }
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _progressTime = 0;
}

#pragma mark - Calculate Curve

CGFloat AnimationFunctionCurveEaseInOut(CGFloat percent)
{
    if (percent == 0.0 || percent == 1.0) {
        return percent;
    }
    if (percent < 0.5) {
        return 0.5 * pow(2, (20 * percent) - 10);
    } else {
        return -0.5 * pow(2, (-20 * percent) + 10) + 1;
    }
}

CGFloat AnimationFunctionCurveEaseIn(CGFloat percent)
{
    return (percent == 0.0) ? percent : pow(2, 10 * (percent - 1));
}

CGFloat AnimationFunctionCurveEaseOut(CGFloat percent)
{
    return (percent == 1.0) ? percent : 1 - pow(2, -10 * percent);
}

CGFloat AnimationFunctionCurveLinear(CGFloat percent)
{
    return percent;
}

@end
