# MPTopFloatingView
Use this view to show new activities inside your app. Support iOS 7+.


# Example
![Demo](https://cloud.githubusercontent.com/assets/10763919/16918272/43cdb20e-4cdb-11e6-875e-d955623b685f.gif)

# Usage
#### 1. Import MPTopFloatingView class
```objective-c
#import <MPTopFloatingView/MPTopFloatingView.h>
```

#### 2. Create an intance
```objective-c
self.newsView = [[MPTopFloatingView alloc] initTopFloatingViewWithDismissBlock:^(MPTopFloatingViewDismissCause cause) {
    if (cause == MPTopFloatingViewDismissCauseTap) {
        //View was tapped! Use this block to execute something..
    }
}];
```
Use one of this alternative initializer to customize the view
##### ・More initializers
```objective-c
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon dismissBlock:(MPTopFloatingViewDismissBlock)dismissBlock;
```
```objective-c
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text color:(nonnull UIColor *)color timeToDismiss:(NSTimeInterval)timeToDismiss dismissBlock:(MPTopFloatingViewDismissBlock)dismissBlock;
```
```objective-c
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text textFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon finalPosition:(float)finalPosition duration:(float)duration dismissBlock:(MPTopFloatingViewDismissBlock)dismissBlock;
```
```objective-c
- (nonnull instancetype)initTopFloatingViewWithText:(nonnull NSString *)text textFont:(nullable UIFont *)font textColor:(nullable UIColor *)textColor color:(nonnull UIColor *)color icon:(nonnull UIImage *)icon finalPosition:(float)finalPosition duration:(float)duration timeToDismiss:(NSTimeInterval)timeToDismiss dismissBlock:(MPTopFloatingViewDismissBlock)dismissBlock;
```

#### 3. Include the view inside the hierarchy
```objective-c
[self.view addSubview:newsView];
// Setup contraints...
```

#### 4. Use this method to start the animation
The parameter is the final state of the view after the animation
```objective-c
[newsView startAnimation:MPTopFloatingViewStatusAppear];
```

# Author
[Cristian Gibert](https://github.com/imchristian)


