//
//  DispatchConfig.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//
#import "DispatchConfig.h"
@implementation DispatchConfig

- (instancetype)initWithSize:(NSInteger)width height:(NSInteger)height {
    _width = width;
    _height = height;
    _threadsPerThreadgroup = MTLSizeMake(16, 16, 1);
    return self;
}

- (MTLSize)threadgroupCount {
    int threadWidth = int(ceilf(float(_width) / float(_threadsPerThreadgroup.width)));
    int threadHeight = int(ceilf(float(_height) / float(_threadsPerThreadgroup.height)));
    return MTLSizeMake(threadWidth, threadHeight, 1);
}
@end
