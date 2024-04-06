//
//  Slab.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/03/31.
//

#import "Slab.h"
#import <iostream>
@implementation Slab
-(instancetype)initSlabWithSource:(id<MTLTexture>)source destTexture:(id<MTLTexture>)dest{
    _source = source;
    _dest = dest;
    return self;
}
-(void)swap{
    id<MTLTexture> tmp = _source;
    _source = _dest;
    _dest = tmp;
}
- (id<MTLTexture>)makeSurfaceWithDevice:(nonnull id<MTLDevice>)_device :(int)width :(int)height :(int)numberOfComponent {
//    id<MTLDevice> _device = mtkView.device;
    MTLPixelFormat pixelFormat;
    if(numberOfComponent == 1)pixelFormat = MTLPixelFormatR32Float;
    if(numberOfComponent == 2)pixelFormat = MTLPixelFormatRG32Float;
    if(numberOfComponent == 3 || numberOfComponent == 4)pixelFormat = MTLPixelFormatRGBA32Float;
    else pixelFormat = MTLPixelFormatR32Float;
//    NSAssert(numberOfComponent > 4, @"numberOfComponent must be less than or equal to 4");
    
    MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
    textureDescriptor.textureType = MTLTextureType2D;
    textureDescriptor.pixelFormat = pixelFormat;

    textureDescriptor.width = width;
    textureDescriptor.height = height;
    
    textureDescriptor.usage = MTLTextureUsageShaderWrite | MTLTextureUsageShaderRead ;
    return [_device newTextureWithDescriptor:textureDescriptor];
}
- (nonnull Slab *)makeSlabWithDevice:(nonnull id<MTLDevice>)_device :(int)width :(int)height :(int)numberOfComponent{
    id<MTLTexture>src = [self makeSurfaceWithDevice:_device :width :height :numberOfComponent];
    id<MTLTexture>dst = [self makeSurfaceWithDevice:_device :width :height :numberOfComponent];
    return [self initSlabWithSource:src destTexture:dst];
}
@end

