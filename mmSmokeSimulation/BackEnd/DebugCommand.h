//
//  DebugCommand.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#ifndef DebugCommand_h
#define DebugCommand_h
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import "ShaderTypes.h"
#import <simd/simd.h>
@interface DebugCommand:NSObject{
}
+(void)printTexture:(nonnull id<MTLTexture>)source textureName:(const char*)textureName;
//[DebugCommand printTexture:testSlab.source textureName:"test"];
@end
#endif /* DebugCommand_h */
