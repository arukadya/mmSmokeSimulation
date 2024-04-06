//
//  Simulator.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#ifndef Simulator_h
#define Simulator_h

#import "AddForce.h"

@interface Simulator : NSObject
-(nonnull instancetype)initWithView:(nonnull MTKView *)mtkView width:(int)width height:(int)height;

@end
#endif /* Simulator_h */
