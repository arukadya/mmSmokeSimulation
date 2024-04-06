//
//  TextureInitializer.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/06.
//

#ifndef TextureInitializer_h
#define TextureInitializer_h
#import "ShaderBase.h"
#import "DispatchConfig.h"
@interface TextureInitializer: ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName value:(float)value;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer outTexture:(nonnull id<MTLTexture>)outTexture;
@end

#endif /* TextureInitializer_h */
