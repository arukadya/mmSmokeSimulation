//
//  AddForce.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#import <Foundation/Foundation.h>
#import "ShaderCommand.h"

@implementation AddForce{
    float _timeStep;
}
- (nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName timeStep:(float)timeStep {
    [self set_functionName:functionName];
    self = [super initWithDevice:_device functionName:self._functionName];
    _timeStep = timeStep;
    return self;
}

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer
            inVelocityTexture:(nonnull id<MTLTexture>)inVelocityTexture
           outVelocityTexture:(nonnull id<MTLTexture>)outVelocityTexture
                  forceTexture:(nonnull id<MTLTexture>)forceTexture{
    id<MTLComputeCommandEncoder> computeEncoder = [_buffer computeCommandEncoder];
    [computeEncoder setComputePipelineState:[super _pipelineState]];
    [computeEncoder setTexture:inVelocityTexture
                       atIndex:0];
    [computeEncoder setTexture:outVelocityTexture
                       atIndex:1];
    [computeEncoder setTexture:forceTexture
                       atIndex:2];
    [computeEncoder setBytes:&_timeStep length:sizeof(float) atIndex:0];
    DispatchConfig *config;
    config = [[DispatchConfig alloc] initWithSize:outVelocityTexture.width height:outVelocityTexture.height];
    [computeEncoder dispatchThreadgroups:config.threadgroupCount
                   threadsPerThreadgroup:config.threadsPerThreadgroup];
    [computeEncoder endEncoding];
}
@end
