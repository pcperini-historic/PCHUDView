//
//  PCHUDView.h
//  PCHUDView
//
//  Created by Patrick Perini on 12/2/11.
//  Licensing information availabe in README.md
//

#pragma mark Imports
@class PCHUDView;
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class DismissView;

#pragma mark - PCHUDViewDelegate Protocol
@protocol PCHUDViewDelegate <NSObject>

- (BOOL)HUDViewShouldShowOverlay: (PCHUDView *)hud;

- (void)HUDViewWillDisplay:       (PCHUDView *)hud;
- (void)HUDView:                  (PCHUDView *)hud didDisplay: (BOOL)displayed;

- (void)HUDViewWillDismiss:       (PCHUDView *)hud;
- (void)HUDView:                  (PCHUDView *)hud didDismiss: (BOOL)dismissed;

@end

#pragma mark - PCHUDView Interface
@interface PCHUDView : UIView
{
    @private
    DismissView *backgroundOverlay;
}

#pragma mark PCHUDView Properties
@property (readonly)          BOOL                  isDisplaying;
@property (nonatomic, retain) id<PCHUDViewDelegate> delegate;

#pragma mark PCHUDView Methods
- (void)display;
- (void)dismiss;

@end