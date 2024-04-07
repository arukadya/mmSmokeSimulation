//
//  DispatchConfig.h
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/01.
//

#ifndef DispatchConfig_h
#define DispatchConfig_h
#import <MetalKit/MetalKit.h>
#import <Metal/Metal.h>

@interface DispatchConfig : NSObject

-(instancetype)initWithSize:(NSInteger)width height:(NSInteger)height;
-(MTLSize)threadgroupCount;
@property NSInteger width;
@property NSInteger height;
@property MTLSize threadsPerThreadgroup;

@end
#endif /* DispatchConfig_h */
