//
//  AddForce.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#import <Foundation/Foundation.h>
#import "ShaderCommand.h"

@implementation Advect{
    float *_timeStep;
}
- (nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device  timeStep:(float)timeStep {
    [self set_functionName:@"xAdvect"];
    self = [super initWithDevice:_device functionName:self._functionName];
    _timeStep = &timeStep;
    return self;
}

- (void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer inTexture:(nonnull id<MTLTexture>)inTexture outTexture:(nonnull id<MTLTexture>)outTexture{
    id<MTLComputeCommandEncoder> computeEncoder = [_buffer computeCommandEncoder];
    [computeEncoder setComputePipelineState:[super _pipelineState]];
    [computeEncoder setTexture:inTexture
                       atIndex:0];
    [computeEncoder setTexture:outTexture
                       atIndex:1];
    [computeEncoder setBytes:_timeStep length:sizeof(float) atIndex:0];
    DispatchConfig *config;
    config = [[DispatchConfig alloc] initWithSize:outTexture.width height:outTexture.height];
    [computeEncoder dispatchThreadgroups:config.threadgroupCount
                   threadsPerThreadgroup:config.threadsPerThreadgroup];
    [computeEncoder endEncoding];
    
}
@end
