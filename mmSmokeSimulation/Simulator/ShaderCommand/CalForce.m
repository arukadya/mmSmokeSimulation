#import <Foundation/Foundation.h>
#import "ShaderCommand.h"
@implementation CalForce{
    float _temprature_amb;
}
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device kTemprature_amb:(float)kTemplature_amb{
    [self set_functionName:@"calForce"];
    self = [super initWithDevice:_device functionName:self._functionName];
    _temprature_amb = kTemplature_amb;
    return self;
}

- (void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer 
                outForceTexture:(nonnull id<MTLTexture>)outForceTexture
                 densityTexture:(nonnull id<MTLTexture>)densityTexture
             density_ambTexture:(nonnull id<MTLTexture>)density_ambTexture
              tempratureTexture:(nonnull id<MTLTexture>)tempratureTexture {
    
    id<MTLComputeCommandEncoder> computeEncoder = [_buffer computeCommandEncoder];
    [computeEncoder setComputePipelineState:[super _pipelineState]];
    [computeEncoder setTexture:outForceTexture
                       atIndex:0];
    [computeEncoder setTexture:densityTexture
                       atIndex:1];
    [computeEncoder setTexture:density_ambTexture
                       atIndex:2];
    [computeEncoder setTexture:tempratureTexture
                       atIndex:3];
    [computeEncoder setBytes:&_temprature_amb length:sizeof(float) atIndex:0];
    DispatchConfig *config;
    config = [[DispatchConfig alloc] initWithSize:outForceTexture.width height:outForceTexture.height];
    [computeEncoder dispatchThreadgroups:config.threadgroupCount
                   threadsPerThreadgroup:config.threadsPerThreadgroup];
    [computeEncoder endEncoding];
}

@end
