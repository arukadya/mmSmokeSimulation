//
//  Renderer.h
//
//  Created by 須之内俊樹 on 2024/03/18.
//

#ifndef Renderer_h
#define Renderer_h
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import "ShaderTypes.h"
#import <simd/simd.h>
#import "Slab.h"
#import "testCommand.h"
#import "ShaderBase.h"
@interface Renderer : NSObject<MTKViewDelegate>

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView;
@end

@interface Simulator : Renderer

@end
#endif /* Renderer_h */
