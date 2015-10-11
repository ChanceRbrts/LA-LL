//
//  Controls.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef Controls_h
#define Controls_h
#include "ControlsEnum.h"
/**@brief The object that handles all controls.*/
@interface Controls : NSObject
/**@brief All of the controls that have been pressed*/
@property NSMutableArray* controlsPressed;
/**@brief All of the controls that have been pressed since the beginning of the current frame*/
@property NSMutableArray* controlsLastPressed;
/**@brief All of the controls that are being held.*/
@property NSMutableArray* controlsHeld;
/**@brief The true initializer.*/
-(id)initWithMore;
/**@brief Records what key has been pressed.*/
-(void)keyPressedWithEvent:(NSEvent *)event;
/**@brief Records what key has been released.*/
-(void)keyReleasedWithEvent:(NSEvent *)event;
/**@brief Sets the controlsPressed array from controlsLastPressed*/
-(void)checkPressed;
/**@brief Sets all controlsPressed to false.*/
-(void)resetControls;
@end

#endif /* Controls_h */
