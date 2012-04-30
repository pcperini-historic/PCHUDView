#PCHUDView#



Inherits From:    UIView

Declared In:      PCHUDView.h


##Overview##

The `PCHUDView` class implements a special kind of view (known as a HUD), typically performing a temporary function.

A HUD is created as a transparent panel (sometimes called a "heads-up display").

Optionally, the HUD may also display a translucent overlay, immediate below itself (in the view hierarchy). This overlay, when tapped, will dismiss the HUD.

<img src="http://i.imgur.com/WzHyS.gif"/>

##Tasks##

###Configuring HUDs###
    isDisplaying (property)
    delegate     (property)

###Displaying and Dismissing HUDs###
    - display
    - dismiss

##Properties##

**delegate**

>The HUD's delegate.

        (nonatomic, retain) id<PCHUDViewDelegate> delegate
        
**isDisplaying**

>Whether the HUD is displaying.

        (readonly) BOOL isDisplaying

##Instance Methods##

**dismiss:**

>Hides the HUD.

        - (void)dismiss

**display**

>Shows the HUD.

        - (void)display

#PCHUDViewDelegate Protocol Reference#



Declared In:      UIHUDView.h


##Overview##

The `PCHUDViewDelegate` protocol defines the optional methods implemented by delegates of `PCHUDView` objects. 

##Tasks##

###Configuring HUDs###
    - HUDViewShouldShowOverlay:
    
###Displaying and Dismissing HUDs###
    - HUDViewWillDisplay:
    - HUDView:didDisplay:
    - HUDViewWillDismiss:
    - HUDView:didDismiss:

##Instance Methods##

**HUDView:didDismiss:**

>This delegate method is called when an `PCHUDView` instance has been hidden.

        - (void)HUDView:(PCHUDView *)hud didDismiss:(BOOL)dismissed

>*Parameters:*

>`hud`

>>The `PCHUDView` that has been hidden.

>`dimissed`

>>`YES` when dismissal was successful; `NO` otherwise.

**HUDView:didDisplay:**

>This delegate method is called when an `PCHUDView` instance has been shown.

        - (void)HUDView:(PCHUDView *)hud didDisplay:(BOOL)displayed

>*Parameters:*

>`hud`

>>The `PCHUDView` that has been shown.

>`dimissed`

>>`YES` when displaying was successful; `NO` otherwise.

**HUDViewWillDismiss:**

>This delegate method is called when an `PCHUDView` instance will be hidden.

        - (void)HUDViewWillDismiss:(PCHUDView *)hud

>*Parameters:*

>`hud`

>>The `PCHUDView` that will be hidden.

**HUDViewWillDisplay:**

>This delegate method is called when an `PCHUDView` instance will be shown.

        - (void)HUDViewWillDisplay:(PCHUDView *)hud

>*Parameters:*

>`hud`

>>The `PCHUDView` that will be shown.

**HUDViewShouldShowOverlay:**

>Returns a Boolean value indicatng whether the HUD should display a translucent functional overlay.

        - (BOOL)HUDViewShouldShowOverlay:(PCHUDView *)hud

>*Parameters:*

>`hud`

>>The `PCHUDView` in question.

>*Return Value:*

>`YES` if the HUD should show a translucent overlay immediately below itself. This overlay, when tapped, dismisses the HUD. Otherwise, `NO`.

#License#

License Agreement for Source Code provided by Patrick Perini

This software is supplied to you by Patrick Perini in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this software constitutes acceptance of these terms. If you do not agree with these terms, please do not use, install, modify or redistribute this software.

In consideration of your agreement to abide by the following terms, and subject to these terms, Patrick Perini grants you a personal, non-exclusive license, to use, reproduce, modify and redistribute the software, with or without modifications, in source and/or binary forms; provided that if you redistribute the software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the software, and that in all cases attribution of Patrick Perini as the original author of the source code shall be included in all such resulting software products or distributions. Neither the name, trademarks, service marks or logos of Patrick Perini may be used to endorse or promote products derived from the software without specific prior written permission from PC. Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Patrick Perini herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the software may be incorporated.

The software is provided by Patrick Perini on an "AS IS" basis. Patrick Perini MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR PCS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL Patrick Perini BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Patrick Perini HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.