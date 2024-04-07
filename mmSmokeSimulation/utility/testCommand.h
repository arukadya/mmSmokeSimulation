//
//  testCommand.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#ifndef testCommand_h
#define testCommand_h
#import "ShaderBase.h"
#import "DispatchConfig.h"
@interface testCommand : ShaderBase
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString *)functionName;

-(void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer outTexture:(nonnull id<MTLTexture>)outTexture;


@end
#endif /* testCommand_h */
