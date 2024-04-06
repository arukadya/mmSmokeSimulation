#import <Foundation/Foundation.h>
#import "TextureInitializer.h"
#import "DebugCommand.h"
@implementation TextureInitializer{
    MTLSize _threadgroupSize;
    MTLSize _threadgroupCount;
    float *_value;
}
-(instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName value:(float)value{
    self = [super initWithDevice:_device functionName:functionName];
    _value = &value;
    return self;
    
}

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer outTexture:(nonnull id<MTLTexture>)outTexture{
    id<MTLComputeCommandEncoder> computeEncoder = [_buffer computeCommandEncoder];
    [computeEncoder setComputePipelineState:[super _pipelineState]];
    [computeEncoder setTexture:outTexture
                       atIndex:0];
    [computeEncoder setBytes:_value length:sizeof(float) atIndex:0];
    DispatchConfig *config;
    [DebugCommand printTexture:outTexture textureName:"initializer.outTexture"];
    config = [[DispatchConfig alloc] initWithSize:outTexture.width height:outTexture.height];
    [computeEncoder dispatchThreadgroups:config.threadgroupCount
                   threadsPerThreadgroup:config.threadsPerThreadgroup];
    [computeEncoder endEncoding];
}

@end
