//
//  ITHUDView.h
//  ITHUDView
//
//  Created by Patrick Perini on 12/2/11.
//  Licensing information availabe in README.md
//

#pragma mark Imports
@class ITHUDView;
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class DismissView;

#pragma mark - ITHUDViewDelegate Protocol
@protocol ITHUDViewDelegate <NSObject>

- (BOOL)HUDViewShouldShowOverlay: (ITHUDView *)hud;

- (void)HUDViewWillDisplay:       (ITHUDView *)hud;
- (void)HUDView:                  (ITHUDView *)hud didDisplay: (BOOL)displayed;

- (void)HUDViewWillDismiss:       (ITHUDView *)hud;
- (void)HUDView:                  (ITHUDView *)hud didDismiss: (BOOL)dismissed;

@end

#pragma mark - ITHUDView Interface
@interface ITHUDView : UIView
{
    @private
    DismissView *backgroundOverlay;
}

#pragma mark ITHUDView Properties
@property (readonly)          BOOL                  isDisplaying;
@property (nonatomic, retain) id<ITHUDViewDelegate> delegate;

#pragma mark ITHUDView Methods
- (void)display;
- (void)dismiss;

@end