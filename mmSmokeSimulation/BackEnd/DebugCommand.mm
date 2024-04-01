//
//  DebugCommand.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#import <Foundation/Foundation.h>
#import "DebugCommand.h"
#import <Eigen/Core>
#include <iostream>

@implementation DebugCommand

+ (void)printTexture:(nonnull id<MTLTexture>)source textureName:(const char*)textureName{
    std::cout << textureName << "," << source.width << "," << source.width << std::endl;
}

@end
