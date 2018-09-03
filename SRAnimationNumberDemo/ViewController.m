//
//  ViewController.m
//  SRAnimationNumberDemo
//
//  Created by https://github.com/guowilling on 2018/2/26.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "ViewController.h"
#import "SRAnimationNumberEngine.h"
#import "UILabel+SRAnimationNumber.h"
#import "UIButton+SRAnimationNumber.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeCurve:SRAnimationNumberCurveEaseInOut];
}

- (IBAction)select:(UISegmentedControl *)sender {
    [self changeCurve:sender.selectedSegmentIndex];
}

- (void)changeCurve:(SRAnimationNumberCurve)curve {
    [self exampleLabel1:curve];
    [self exampleLabel2:curve];
    [self exampleLabel3:curve];
    
    [self exampleButton1:curve];
    [self exampleButton2:curve];
    [self exampleButton3:curve];
}

#pragma mark - UIlabel

- (void)exampleLabel1:(SRAnimationNumberCurve)curve {
    [self.label1 sr_animationFromNumber:0 toNumber:100 duration:3.0 curve:curve format:^NSString *(CGFloat currentNumber) {
        return [NSString stringWithFormat:@"%.2f", currentNumber];
    }];
}

- (void)exampleLabel2:(SRAnimationNumberCurve)curve {
    [self.label2 sr_animationFromNumber:0 toNumber:100 duration:3.0 curve:curve attributedFormat:^NSAttributedString *(CGFloat currentNumber) {
        NSString *string = [NSString stringWithFormat:@"%.0f%%", currentNumber];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:25],
                                          NSForegroundColorAttributeName: [UIColor redColor]}
                                  range:NSMakeRange(0, string.length)];
        return attributedString;
    } completion:^(CGFloat endNumber) {
        NSLog(@"completion: %.2f", endNumber);
        // do more things...
//        self.label2.backgroundColor = [UIColor whiteColor];
    }];
}

- (void)exampleLabel3:(SRAnimationNumberCurve)curve {
    [self.label3 sr_animationFromNumber:0 toNumber:123456789 duration:3.0 curve:curve format:^NSString *(CGFloat currentNumber) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.positiveFormat = @"###,##0.00";
        NSNumber *amountNumber = [NSNumber numberWithFloat:currentNumber];
        return [NSString stringWithFormat:@"¥%@", [formatter stringFromNumber:amountNumber]];
    }];
}

#pragma mark - UIButton

- (void)exampleButton1:(SRAnimationNumberCurve)curve {
    [self.button1 sr_animationFromNumber:0 toNumber:100 duration:3.0 curve:curve format:^NSString *(CGFloat currentNumber) {
        return [NSString stringWithFormat:@"%.2f", currentNumber];
    }];
}

- (void)exampleButton2:(SRAnimationNumberCurve)curve {
    [self.button2 sr_animationFromNumber:0 toNumber:100 duration:3.0 curve:curve attributedFormat:^NSAttributedString *(CGFloat currentNumber) {
        NSString *string = [NSString stringWithFormat:@"%.0f%%", currentNumber];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:25],
                                          NSForegroundColorAttributeName: [UIColor redColor]}
                                  range:NSMakeRange(0, string.length)];
        return attributedString;
    } completion:^(CGFloat endNumber) {
        NSLog(@"completion: %.2f", endNumber);
        // do more things...
//        self.button2.backgroundColor = [UIColor whiteColor];
    }];
}

- (void)exampleButton3:(SRAnimationNumberCurve)curve {
    [self.button3 sr_animationFromNumber:0 toNumber:123456789 duration:3.0 curve:curve format:^NSString *(CGFloat currentNumber) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.positiveFormat = @"###,##0.00";
        NSNumber *amountNumber = [NSNumber numberWithFloat:currentNumber];
        return [NSString stringWithFormat:@"¥%@", [formatter stringFromNumber:amountNumber]];
    }];
}

@end
