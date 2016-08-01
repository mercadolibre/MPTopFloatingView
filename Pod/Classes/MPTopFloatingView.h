//
// MPTopFloatingView
//
// Created by Cristian Leonel Gibert on 7/13/16.
// Copyright © 2016 MercadoPago. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
   Use this enum to indicate the status of the view
 */
typedef NS_ENUM (NSInteger, MPTopFloatingViewStatus) {
	MPTopFloatingViewStatusAppear = 0,
	MPTopFloatingViewStatusDisappear = 1,
};

/**
 *  Specify the dismiss cause for the Floating View
 */
typedef NS_ENUM (NSInteger, MPTopFloatingViewDismissCause) {
	/**
	 *  Floating view is dismissed because user tap on the view
	 */
	MPTopFloatingViewDismissCauseTap,
	/**
	 *  Floating view is dismissed because auto dismiss was enabled.
	 */
	MPTopFloatingViewDismissCauseAuto
};

/**
 *  Dismiss block used as a callback when the floating view is dismissed
 *
 *  @param cause of the dismiss
 */
typedef void (^MPTopFloatingViewDismissBlock)(MPTopFloatingViewDismissCause cause);

@interface MPTopFloatingView : UIView

///---------------------
/// @name Initialization
///---------------------

/**
   Use this method to create an instance with the default configuration
   @param dismissBlock The block to be executed when the view is dismissed
 */
- (nonnull instancetype)initTopFloatingViewWithDismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock;

/**
   This method need all the paremers for full customization
   @param text The text inside the view
   @param color Color to fill the background view
   @param icon Icon to add inside the view
   @param dismissBlock The block to be executed when the view is dismissed
 */
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock;

/**
 *  Use this method to create a floating view with custom text, color and the time for the view to be shown.
 *
 *  @param text              The text inside the view
 *  @param color             Color to fill the background view
 *  @param timeToDismiss     After this time the view will be dismissed (in seconds)
 *  @param dismissBlock The block to be executed when the view is dismissed
 *
 */
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text color:(nonnull UIColor *)color timeToDismiss:(NSTimeInterval)timeToDismiss dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock;

/**
   Use this method to create a floating view with a full customization. The view will be not auto dismissed.
   @param text The text inside the view
   @param textFont With this param you can change the font type of the text
   @param textColor Customize the color of the text
   @param color Color to fill the background view
   @param icon Icon to add inside the view
   @param finalPosition Use this param to determine the final position of the view when appear on the screen
   @param dismissBlock The block to be executed when the view is dismissed
 */
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text textFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon finalPosition:(float)finalPosition duration:(float)duration dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock;

/**
   This is the designated initializer
   @param text The text inside the view
   @param textFont With this param you can change the font type of the text
   @param textColor Customize the color of the text
   @param color Color to fill the background view
   @param icon Icon to add inside the view
   @param finalPosition Use this param to determine the final position of the view when appear on the screen
   @param timeToDismiss After this time the view will be dismissed
   @param dismissBlock The block to be executed when the view is dismissed
 */
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text textFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon finalPosition:(float)finalPosition duration:(float)duration timeToDismiss:(NSTimeInterval)timeToDismiss dismissBlock:(nonnull MPTopFloatingViewDismissBlock)dismissBlock;

///---------------------
/// @name Animations
///---------------------

/**
   Use this method to trigger the animation
   @param status The status is a representation of the desire animation
 */
- (void)startAnimation:(MPTopFloatingViewStatus)status;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Text inside the view. Set this property to change the message after creating the view.
 */
@property (strong, nonatomic) NSString *text;

/**
 *  The current status of the floating view (read-only)
 */
@property (readonly) MPTopFloatingViewStatus status;

NS_ASSUME_NONNULL_END

@end
