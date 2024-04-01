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

-(nonnull instancetype)initWithSize:(int)width height:(int)height;
-(MTLSize)threadgroupCount;
@property int width;
@property int height;
@property MTLSize threadsPerThreadgroup;

@end
//@interface DispatchConfig : NSObject
//+(MTLSize)threadsPerThreadgroup;
//+(MTLSize)threadgroupCount:(int)width height:(int)height;
//@end
#endif /* DispatchConfig_h */
