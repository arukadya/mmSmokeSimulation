//
//  Slab.hpp
//  mmSmokeSimulation
//  Created by 須之内俊樹 on 2024/03/31.


#ifndef Slab_h
#define Slab_h
#import <MetalKit/MetalKit.h>
#import <Metal/Metal.h>

@interface Slab : NSObject
- (nonnull instancetype)initSlabWithSource:(nonnull id<MTLTexture>)source destTexture:(nonnull id<MTLTexture>)dest;

- (void)swap;

-(nonnull instancetype)makeSurfaceWithDevice:(nonnull id<MTLDevice>)_device :(int)width :(int)height :(int)numberOfComponent;

-(nonnull instancetype)makeSlabWithDevice:(nonnull id<MTLDevice>)_device :(int)width :(int)height :(int)numberOfComponent;

@property (nonnull)id<MTLTexture>source;
@property (nonnull)id<MTLTexture>dest;

@end

#endif /* Slab_h */
