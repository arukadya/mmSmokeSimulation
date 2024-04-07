//
//  Shaders.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/07.
//

#ifndef ShaderCommand_h
#define ShaderCommand_h
#import "ShaderBase.h"
#import "DispatchConfig.h"
@interface AddForce : ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName timeStep:(float)timeStep;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer
             inVelocityTexture:(nonnull id<MTLTexture>)inVelocityTexture
            outVelocityTexture:(nonnull id<MTLTexture>)outVelocityTexture
                   forceTexture:(nonnull id<MTLTexture>)forceTexture;
@end

@interface CalForce : ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device kTemprature_amb:(float)kTemplature_amb;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer
            outForceTexture:(nonnull id<MTLTexture>)outForceTexture
           densityTexture:(nonnull id<MTLTexture>)densityTexture
                density_ambTexture:(nonnull id<MTLTexture>)density_ambTexture
           tempratureTexture:(nonnull id<MTLTexture>)tempratureTexture;
@end

@interface Advect : ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device timeStep:(float)timeStep;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer inTexture:(nonnull id<MTLTexture>)inTexture outTexture:(nonnull id<MTLTexture>)outTexture;
@end



@interface TextureInitializer: ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName value:(float)value;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer outTexture:(nonnull id<MTLTexture>)outTexture;
@property float _value;
@end
#endif /* ShaderCommand_h */
