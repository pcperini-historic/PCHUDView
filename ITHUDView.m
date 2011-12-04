//
//  ITHUDView.m
//  ITHUDView
//
//  Created by Patrick Perini on 12/2/11.
//  Licensing information availabe in README.md
//

#import "ITHUDView.h"

#pragma mark Macros and Interfaces
@interface DismissView : UIView @end

//Self
#define CornerRadius            5
#define BackgroundColor         [UIColor colorWithWhite: 0.0 alpha: .75]
#define GradientHeight          30
#define GradientWidth           1024
#define GradientStartColor      [UIColor colorWithWhite: 1.0 alpha: .15]
#define GradientEndColor        [UIColor colorWithWhite: 1.0 alpha: .00]

//Overlay
#define OverlayColorTransparent [UIColor colorWithWhite: 0.0 alpha: .00]
#define OverlayColorTranslucent [UIColor colorWithWhite: 0.0 alpha: .50]
#define OverlayWasTouched       @"overlay_was_touched"

//Animation
#define BounceRatio             1.05
#define MainAnimationDuration   .36
#define AccentAnimationDuration .18
#define FadeAnimationDelay      .06

#pragma mark - ITHUDView Implmentation
@implementation ITHUDView

@synthesize delegate;

#pragma mark UIView Methods
- (id)initWithFrame:(CGRect)frame
{   
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor: BackgroundColor];
        
        [self.layer setMasksToBounds: YES];
        [self.layer setCornerRadius: CornerRadius];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        CGRect gradientFrame = self.bounds;
        gradientFrame.size.height = GradientHeight;
        gradientFrame.size.width = GradientWidth;
        [gradient setFrame: gradientFrame];
        [gradient setColors: [NSArray arrayWithObjects: (id) [GradientStartColor CGColor],
                                                        (id) [GradientEndColor CGColor],
                                                        nil]];
        [self.layer insertSublayer: gradient atIndex: 0];
        
        [self setHidden: YES];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(dismiss)
                                                     name: OverlayWasTouched
                                                   object: nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)addSubview:(UIView *)view
{
    [view setAlpha: 0.0];
    [super addSubview: view];
}

#pragma mark ITHUDView Methods
- (BOOL)shouldShowOverlay
{
    return (!delegate                                                           ||
            ![delegate respondsToSelector:@selector(HUDViewShouldShowOverlay:)] ||
            [delegate HUDViewShouldShowOverlay: self]);
}

- (void)display
{
    if (delegate && [delegate respondsToSelector:@selector(HUDViewWillDisplay:)])
    {
        [delegate HUDViewWillDisplay: self];
    }
    
    __block CGRect startFrame = CGRectZero;
    startFrame.origin = CGPointMake((self.superview.frame.size.width / 2) - (startFrame.size.width / 2),
                                    (self.superview.frame.size.height / 2) - (startFrame.size.height / 2));
    __block CGRect endFrame = self.frame;
    endFrame.size.width *= BounceRatio;
    endFrame.size.height *= BounceRatio;
    endFrame.origin = CGPointMake((self.superview.frame.size.width / 2) - (endFrame.size.width / 2),
                                  (self.superview.frame.size.height / 2) - (endFrame.size.height / 2));
    
    [self setFrame: startFrame];
    [self setHidden: NO];
    
    if ([self shouldShowOverlay])
    {
        backgroundOverlay = [[DismissView alloc] initWithFrame: self.window.frame];
        [backgroundOverlay setBackgroundColor: OverlayColorTransparent];
        [self.superview insertSubview: backgroundOverlay belowSubview: self];
    }
    
    [UIView animateWithDuration: MainAnimationDuration
     animations: ^
     {
         if (backgroundOverlay)
         {
            [backgroundOverlay setBackgroundColor: OverlayColorTranslucent];
         }
         
         [self setFrame: endFrame];
     }
     completion: ^(BOOL completed)
     {
         endFrame.size.width /= BounceRatio;
         endFrame.size.height /= BounceRatio;
         endFrame.origin = CGPointMake((self.superview.frame.size.width / 2) - (endFrame.size.width / 2),
                                       (self.superview.frame.size.height / 2) - (endFrame.size.height / 2));
         
         [UIView animateWithDuration: AccentAnimationDuration
          animations: ^
          {
              [self setFrame: endFrame];
          }
          completion: ^(BOOL completed)
          {
              [UIView animateWithDuration: AccentAnimationDuration - FadeAnimationDelay
               animations: ^
               {
                   for (UIView *subview in [self subviews])
                   {
                       [subview setAlpha: 1.0];
                   } 
               }];
              
              if (delegate && [delegate respondsToSelector:@selector(HUDView:didDisplay:)])
              {
                  [delegate HUDView: self
                         didDisplay: completed];
              }
          }];
     }];
}

- (void)dismiss
{
    if (delegate && [delegate respondsToSelector:@selector(HUDViewWillDismiss:)])
    {
        [delegate HUDViewWillDismiss: self];
    }
    
    __block CGRect startFrame = self.frame;
    __block CGRect endFrame = CGRectZero;
    endFrame.origin = CGPointMake((self.superview.frame.size.width / 2) - (endFrame.size.width / 2),
                                  (self.superview.frame.size.height / 2) - (endFrame.size.height / 2));
    
    [UIView animateWithDuration: AccentAnimationDuration
     animations: ^
     {
         for (UIView *subview in [self subviews])
         {
             [subview setAlpha: 0.0];
         } 
     }];
    
    [UIView animateWithDuration: MainAnimationDuration
                          delay: FadeAnimationDelay
                        options: UIViewAnimationOptionTransitionNone
     animations: ^
     {
         if (backgroundOverlay)
         {
             [backgroundOverlay setBackgroundColor: OverlayColorTransparent];
         }
         
         [self setFrame: endFrame];
     }
     completion: ^(BOOL completed)
     {
         if (backgroundOverlay)
         {
             [backgroundOverlay removeFromSuperview];
             backgroundOverlay = nil;
         }
         
         [self setHidden: YES];
         [self setFrame: startFrame];
         
         if (delegate && [delegate respondsToSelector:@selector(HUDView:didDismiss:)])
         {
             [delegate HUDView: self
                    didDismiss: completed];
         }
     }];
}

@end

#pragma mark - DismissView Implementation
@implementation DismissView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName: OverlayWasTouched object: nil];
}

@end