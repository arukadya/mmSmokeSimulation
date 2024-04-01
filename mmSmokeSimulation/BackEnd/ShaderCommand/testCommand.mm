//
//  testCommand.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#import <Foundation/Foundation.h>
#import "testCommand.h"
#import "DispatchConfig.h"
@implementation testCommand{
    MTLSize _threadgroupSize;
    MTLSize _threadgroupCount;
}
-(instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName{
    self = [super initWithDevice:_device functionName:functionName];
    return self;
    
}

- (void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer outTexture:(nonnull id<MTLTexture>)outTexture{
    id<MTLComputeCommandEncoder> computeEncoder = [_buffer computeCommandEncoder];
    [computeEncoder setComputePipelineState:[super pipelineState]];
    [computeEncoder setTexture:outTexture
                       atIndex:0];
    DispatchConfig *config;
    config = [[DispatchConfig alloc] initWithSize:outTexture.width height:outTexture.height];
    [computeEncoder dispatchThreadgroups:config.threadgroupCount
                   threadsPerThreadgroup:config.threadsPerThreadgroup];
    [computeEncoder endEncoding];
}

@end
