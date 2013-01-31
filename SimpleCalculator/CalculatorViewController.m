//
//  CalculatorViewController.m
//  SimpleCalculator
//
//  Created by Olexandr Shalakhin on 1/31/13.
//  Copyright (c) 2013 Olexandr Shalakhin. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (nonatomic) double previousValue;
@property (nonatomic) double currentValue;
@property (nonatomic) NSString *operation;
@property (nonatomic) BOOL computeWasPressed;

- (double)compute;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize previousValue = _previousValue;
@synthesize operation = _operation;
@synthesize currentValue = _currentValue;
@synthesize computeWasPressed = _computeWasPressed;

- (double)compute {
    double result = 0;
    NSLog(@"%g %@ %g", self.previousValue, self.operation, self.currentValue);
    if ([self.operation isEqualToString:@"+"]) {
        result = self.previousValue + self.currentValue;
    } else if ([self.operation isEqualToString:@"-"]) {
        result = self.previousValue - self.currentValue;
    } else if ([self.operation isEqualToString:@"*"]) {
        result = self.previousValue * self.currentValue;
    } else if ([self.operation isEqualToString:@"/"]) {
        // can't divide on zero
        if (self.currentValue) {
            result = self.previousValue / self.currentValue;
        }
    }
    return result;
}

- (IBAction)digitPressed:(UIButton *)sender {
    if (self.computeWasPressed) {
        self.display.text = @"";
    }
    NSString *digit = sender.currentTitle;
    self.display.text = [self.display.text stringByAppendingString:digit];
    if ([[self.display.text substringToIndex:1] isEqual: @"0"]) {
        self.display.text = [self.display.text substringFromIndex:1];
    }
    self.computeWasPressed = NO;
}

- (IBAction)computePressed:(UIButton *)sender {
    self.computeWasPressed = YES;

    if (self.previousValue) {
        // here we have to compute
        self.currentValue = [self.display.text doubleValue];
        if (!self.operation) {
            self.operation = sender.currentTitle;
        }
        double result = self.compute;
        self.display.text = [NSString stringWithFormat:@"%g", result];
        self.previousValue = result;
        self.operation = sender.currentTitle;
    } else {
        // here we get first param
        self.previousValue = [self.display.text doubleValue];
        self.operation = sender.currentTitle;
    }
}
- (IBAction)finallyPressed {
    if (self.previousValue && self.operation) {
        self.currentValue = [self.display.text doubleValue];
        self.display.text = [NSString stringWithFormat:@"%g", self.compute];
    }
}

- (IBAction)clearAll {
    if (self.previousValue) {
        self.previousValue = 0;
    }
    if (self.currentValue) {
        self.currentValue = 0;
    }
    if (self.operation) {
        self.operation = nil;
    }
    self.display.text = @"0";
}

@end
