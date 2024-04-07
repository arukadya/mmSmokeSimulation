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
@interface AddForce : ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName timeStep:(float)timeStep;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer
             inVelocityTexture:(nonnull id<MTLTexture>)inVelocityTexture
            outVelocityTexture:(nonnull id<MTLTexture>)outVelocityTexture
                   forceTexture:(nonnull id<MTLTexture>)forceTexture;
@end
#endif /* AddForce_h */
