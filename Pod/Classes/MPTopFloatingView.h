//
//  MPTopFloatingView
//
//  Created by Cristian Leonel Gibert on 7/13/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Use this enum to indicate the status of the view
 */
typedef NS_ENUM(NSInteger, MPTopFloatingViewStatus) {
	MPTopFloatingViewStatusAppear = 0,
	MPTopFloatingViewStatusDisappear = 1,
};

@interface MPTopFloatingView : UIView

///---------------------
/// @name Initialization
///---------------------

/** 
 Use this method to create an instance with the default configuration
 @param newsActionHandler The block to be executed when the view is tapped
 */
- (nonnull instancetype)initTopFloatingViewWithOnTapBlock:(nullable void (^)())newsActionHandler;

/**
 This method need all the paremers for full customization
 @param text The text inside the view
 @param color Color to fill the background view
 @param icon Icon to add inside the view
 @param newsActionHandler The block to be executed when the view is tapped
 */
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon onTapBlock:(nullable void (^)())newsActionHandler;

/**
 This is the designated initializer
 @param text The text inside the view
 @param textFont With this param you can change the font type of the text
 @param textColor Customize the color of the text
 @param color Color to fill the background view
 @param icon Icon to add inside the view
 @param finalPosition Use this param to determine the final position of the view when appear on the screen
 @param newsActionHandler The block to be executed when the view is tapped
 */
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text textFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon finalPosition:(float)finalPosition duration:(float)duration onTapBlock:(nullable void (^)())newsActionHandler;

///---------------------
/// @name Animations
///---------------------

/**
 Use this method to trigger the animation
 @param status The status is a representation of the desire animation
 */
- (void)startAnimation:(MPTopFloatingViewStatus)status;

@end
