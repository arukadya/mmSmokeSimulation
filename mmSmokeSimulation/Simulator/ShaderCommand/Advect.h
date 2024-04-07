//
//  AddForce.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#ifndef AddForce_h
#define AddForce_h
#import "ShaderBase.h"
#import "DispatchConfig.h"
@interface Advect : ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device timeStep:(float)timeStep;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer inTexture:(nonnull id<MTLTexture>)inTexture outTexture:(nonnull id<MTLTexture>)outTexture;
@end
#endif /* AddForce_h */
