//
//  ShaderBase.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#import <Foundation/Foundation.h>
#import "ShaderBase.h"

@implementation ShaderBase

- (nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device functionName:(nonnull NSString*)functionName;{
    NSError *error = NULL;
    _functionName = functionName;
    id<MTLLibrary> defaultLibrary = [_device newDefaultLibrary];
    // Load the image processing function from the library and create a pipeline from it.
    id<MTLFunction> kernelFunction = [defaultLibrary newFunctionWithName:_functionName];
    _pipelineState = [_device newComputePipelineStateWithFunction:kernelFunction error:&error];
    NSAssert(_pipelineState, @"Failed to create compute pipeline state: %@", error);
    
    
    
    return self;
}

@end


