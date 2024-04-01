//
//  ShaderBase.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#ifndef ShaderBase_h
#define ShaderBase_h
#import <MetalKit/MetalKit.h>
#import <Metal/Metal.h>

@interface ShaderBase : NSObject
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString*)functionName;
@property (nonnull)NSString* functionName;
@property (nonnull)id<MTLComputePipelineState> pipelineState;
@end




#endif /* ShaderBase_h */
