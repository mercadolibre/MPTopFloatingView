//
//  MPTopFloatingView.m
//
//  Created by Cristian Leonel Gibert on 7/13/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

#import "MPTopFloatingView.h"

// Use this macro to determine the current iOS version
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface MPTopFloatingView()

// IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

// Private properties
@property (nonatomic) MPTopFloatingViewStatus currentStatus;

// Layer and animation properties
@property (nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) CALayer *animLayer;

// Default view positions
@property (nonatomic) float initialPositionY;
@property (nonatomic) float initialPositionX;
@property (nonatomic) float finalPosition;

// Auto dismiss
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval timeToDismiss;
@property (nonatomic, copy) MPTopFloatingViewDismissBlock dismissBlock;

@end

@implementation MPTopFloatingView

#pragma mark initializers
- (nonnull instancetype)initTopFloatingViewWithDismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock
{
    // Setup the default configuration
    self = [self initTopFloatingViewWithText:@"New Activities" color:[UIColor colorWithRed:0 green:0.62 blue:0.89 alpha:1] icon:[UIImage imageNamed:@"up-arrow"] dismissBlock:dismissBlock];
    
    return self;
}

- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock
{
    // Setup a default final position and duration if this method is used
    self = [self initTopFloatingViewWithText:text textFont:nil textColor:nil color:color icon:icon finalPosition:30 duration:0.5 dismissBlock:dismissBlock];
    
    return self;
}

- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text textFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon finalPosition:(float)finalPosition duration:(float)duration dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock
{
    self = [self initTopFloatingViewWithText:text textFont:font textColor:textColor color:color icon:icon finalPosition:finalPosition duration:duration timeToDismiss:0 dismissBlock:dismissBlock];
    
    return self;
}

- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text color:(nonnull UIColor *)color timeToDismiss:(NSTimeInterval)timeToDismiss dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock {
    
    self = [self initTopFloatingViewWithText:text textFont:nil textColor:nil color:color icon:[UIImage imageNamed:@"up-arrow"] finalPosition:30 duration:0.5 timeToDismiss:timeToDismiss dismissBlock:dismissBlock];
    
    return self;
}

- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text textFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon finalPosition:(float)finalPosition duration:(float)duration timeToDismiss:(NSTimeInterval)timeToDismiss dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock
{
    if (self = [super init]) {
        
        // Verify the param required
        NSAssert(color, @"Color can not be nil.");
        NSAssert(icon, @"Icon can not be nil.");
        NSAssert(text, @"Text can not be nil.");
        NSAssert(finalPosition, @"finalPosition can not be nil.");
        NSAssert(duration, @"duration can not be nil.");
        NSAssert(text.length, @"Text can not be empty.");
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MPTopFloatingView" owner:self options:nil] lastObject];
        
        // Setup the style
        [self setupStyleWithText:text textFont:font textColor:textColor finalPosition:finalPosition duration:duration backgroundColor:color icon:icon timeToDismiss:timeToDismiss dismissBlock:dismissBlock];
        [self handleTapAction];
    }
    
    return self;
}

#pragma mark setup
- (void)setupStyleWithText:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor finalPosition:(float)finalPosition duration:(float)duration backgroundColor:(UIColor *)color icon:(UIImage *)icon timeToDismiss:(NSTimeInterval)timeToDismiss dismissBlock:(MPTopFloatingViewDismissBlock)dismissBlock
{
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.currentStatus = MPTopFloatingViewStatusDisappear;
    self.backgroundColor = color;
    self.textLabel.text = text;
    self.iconImageView.image = icon;
    self.finalPosition = finalPosition;
    self.duration = duration;
    self.timeToDismiss = timeToDismiss;
    self.dismissBlock = dismissBlock;
    
    if (font) {
        [self.textLabel setFont:font];
    }
    
    if (textColor) {
        [self.textLabel setTextColor:textColor];
    }
}

// This method make all the changes in the view to match the final result of the animation
- (void)setupFinalState:(MPTopFloatingViewStatus)status
{
    if (status == MPTopFloatingViewStatusAppear) {
        if (self.timeToDismiss > 0) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeToDismiss
                                                          target:self
                                                        selector:@selector(autoDismiss)
                                                        userInfo:nil
                                                         repeats:NO];
        }
        self.currentStatus = MPTopFloatingViewStatusAppear;
        self.center = CGPointMake(self.initialPositionX, self.finalPosition);
        return;
    }
    
    if (status == MPTopFloatingViewStatusDisappear) {
        [self.timer invalidate];
        self.currentStatus = MPTopFloatingViewStatusDisappear;
        self.center = CGPointMake(self.initialPositionX, self.initialPositionY);
        return;
    }
}

- (void)setText:(NSString *)text
{
    self.textLabel.text = text;
}

- (NSString *)text
{
    return self.textLabel.text;
}

- (MPTopFloatingViewStatus)status
{
    return self.currentStatus;
}

#pragma mark animations
- (void)startAnimation:(MPTopFloatingViewStatus)status
{
    self.animLayer = self.layer;
    
    // Save the initial position of the view
    if (!self.initialPositionY && !self.initialPositionX) {
        self.initialPositionX = CGRectGetMidX(self.frame);
        self.initialPositionY = CGRectGetMinY(self.frame);
    }
    
    if (status == MPTopFloatingViewStatusAppear) {
        // perform the animation depending the iOS version
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
            [self showSpringAnimation];
        } else {
            [self showAnimation];
        }
        return;
    }
    
    if (status == MPTopFloatingViewStatusDisappear) {
        [self hideAnimation];
        return;
    }
}

// This animation is used for old system versions
- (void)showAnimation
{
    // Prevent show the view if is not hidden
    if (self.currentStatus == MPTopFloatingViewStatusDisappear) {
        CABasicAnimation *showAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        showAnimation.duration = 0.2;
        showAnimation.fromValue = [NSNumber numberWithFloat:self.initialPositionY];
        showAnimation.toValue = [NSNumber numberWithFloat:self.finalPosition];
        [self setupFinalState:MPTopFloatingViewStatusAppear];
        [self.layer addAnimation:showAnimation forKey:nil];
    }
}

- (void)showSpringAnimation
{
    // Prevent show the view if is not hidden
    if (self.currentStatus == MPTopFloatingViewStatusDisappear) {
        CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position.y"];
        spring.damping = 5;
        spring.fromValue = [NSNumber numberWithFloat:self.initialPositionY];
        spring.toValue = [NSNumber numberWithFloat:self.finalPosition];
        spring.duration = self.duration;
        [self setupFinalState:MPTopFloatingViewStatusAppear];
        [self.layer addAnimation:spring forKey:nil];
    }
}

- (void)hideAnimation
{
    // Prevent hide the view if is not already presented
    if (self.currentStatus == MPTopFloatingViewStatusAppear) {
        CABasicAnimation *hideAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        hideAnimation.duration = 0.2;
        hideAnimation.fromValue = [NSNumber numberWithFloat:self.finalPosition];
        hideAnimation.toValue = [NSNumber numberWithFloat:self.initialPositionY];
        hideAnimation.removedOnCompletion = YES;
        [self setupFinalState:MPTopFloatingViewStatusDisappear];
        [self.layer addAnimation:hideAnimation forKey:nil];
    }
}

- (void)autoDismiss
{
    [self startAnimation:MPTopFloatingViewStatusDisappear];
    if (self.dismissBlock) {
        self.dismissBlock(MPTopFloatingViewDismissCauseAuto);
    }
}

- (void)handleTapAction
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gesture];
}

// Tap action
- (void)viewTapped:(UIGestureRecognizer *) sender
{
    [self startAnimation:MPTopFloatingViewStatusDisappear];
    
    if (self.dismissBlock) {
        self.dismissBlock(MPTopFloatingViewDismissCauseTap);
    }
}

@end