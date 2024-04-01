//
//  AddForce.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#import <Foundation/Foundation.h>
#import "AddForce.h"

@implementation AddForce
- (nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName timeStep:(float)timeStep {
    self = [super initWithDevice:_device functionName:functionName];
    _timeStep = timeStep;
    return self;
}

- (void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer inTexture:(nonnull id<MTLTexture>)inTexture outTexture:(nonnull id<MTLTexture>)outTexture{
    id<MTLComputeCommandEncoder> computeEncoder = [_buffer computeCommandEncoder];
    [computeEncoder setComputePipelineState:[super pipelineState]];
    [computeEncoder setTexture:inTexture
                       atIndex:0];
    [computeEncoder setTexture:outTexture
                       atIndex:1];
    DispatchConfig *config;
    config = [[DispatchConfig alloc] initWithSize:outTexture.width height:outTexture.height];
    [computeEncoder dispatchThreadgroups:config.threadgroupCount
                   threadsPerThreadgroup:config.threadsPerThreadgroup];
    [computeEncoder endEncoding];
    
}
@end
