//
//  Fluid.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/04.
//

#ifndef Fluid_h
#define Fluid_h
#import <MetalKit/MetalKit.h>
#import <Metal/Metal.h>
#import "Slab.h"
#import "ShaderBase.h"
#import "TextureInitializer.h"
#import "testCommand.h"

@interface Fluid : NSObject
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device commnandBuffer: (nonnull id<MTLCommandBuffer>)_buffer width:(int)width height:(int)height;
-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer;
//-(void) createVelocityInitialState;
//-(void) createPressureInitialState;
//-(void) createDensityInitialState;
//-(void) createDensity_ambInitialState;
//-(void) createTemplatureInitialState;
@property (nonnull)id<MTLTexture>_currentTexture;
@end
#endif /* Fluid_h */
