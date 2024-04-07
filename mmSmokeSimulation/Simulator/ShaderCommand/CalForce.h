//
//  AddForce.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#ifndef CalForce_h
#define CalForce_h
#import "ShaderBase.h"
#import "DispatchConfig.h"
@interface CalForce : ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device kTemprature_amb:(float)kTemplature_amb;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer
            outForceTexture:(nonnull id<MTLTexture>)outForceTexture
           densityTexture:(nonnull id<MTLTexture>)densityTexture
                density_ambTexture:(nonnull id<MTLTexture>)density_ambTexture
           tempratureTexture:(nonnull id<MTLTexture>)tempratureTexture;
@end
#endif /* CalForce_h_h */
