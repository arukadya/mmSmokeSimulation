//
//  Fluid.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/04.
//

#import <Foundation/Foundation.h>
#import "Fluid.h"

static int kDencityComponent = 1;
static int kForceComponent = 4;
static float kAmbientTemprature = 25.0;

@implementation Fluid{
    int _width;
    int _height;
    Slab *_xVelocity;
    Slab *_yVelocity;
    Slab *_pressure;
    Slab *_density;
    Slab *_density_amb;
    Slab *_templature;
    Slab *_force;
    TextureInitializer *_textureInitializer;
    
    Slab *testSlab;
    testCommand *_testCommand;
}
-(nonnull instancetype)initWithDevice:(nonnull id<MTLDevice>)_device commnandBuffer: (nonnull id<MTLCommandBuffer>)_buffer width:(int)width height:(int)height{
    _width = width;
    _height = height;
    _xVelocity = [[Slab alloc] makeSlabWithDevice:_device :_width+1 :_height :1];
    _yVelocity = [[Slab alloc] makeSlabWithDevice:_device :_width :_height+1 :1];
    _pressure = [[Slab alloc] makeSlabWithDevice:_device :_width :_height :1];
    _density = [[Slab alloc] makeSlabWithDevice:_device :_width :_height :1];
    _density_amb = [[Slab alloc] makeSlabWithDevice:_device :_width :_height :1];
    _templature = [[Slab alloc] makeSlabWithDevice:_device :_width :_height :1];
    _force = [[Slab alloc] makeSlabWithDevice:_device :_width :_height :1];
    _textureInitializer = [[TextureInitializer alloc] initWithDevice:_device functionName:@"initializeUniform" value:0.0];
    
    testSlab = [[Slab alloc] makeSlabWithDevice:_device :256 :256 :1];
    _testCommand = [[testCommand alloc] initWithDevice:_device functionName:@"simasima"];
    
    //initialize uniform(velocity pressure density_amb force)
    [_textureInitializer encodeWithCommandBuffer:_buffer outTexture:_xVelocity.source];
    [_textureInitializer encodeWithCommandBuffer:_buffer outTexture:_yVelocity.source];
    [_textureInitializer encodeWithCommandBuffer:_buffer outTexture:_pressure.source];
    [_textureInitializer encodeWithCommandBuffer:_buffer outTexture:_density_amb.source];
    [_textureInitializer encodeWithCommandBuffer:_buffer outTexture:_force.source];
    //initialize with area(density,templature)
    [_textureInitializer set_functionName:@"initializeWithArea"];
    [_textureInitializer encodeWithCommandBuffer:_buffer outTexture:_density.source];
    [_textureInitializer encodeWithCommandBuffer:_buffer outTexture:_templature.source];
//    [self createVelocityInitialState];
//    [self createDensityInitialState];
//    [self createDensity_ambInitialState];
//    [self createTemplatureInitialState];
//    [self createPressureInitialState];
    return self;
}
//- (void)createVelocityInitialState {
//    
//}
//
//- (void)createDensityInitialState {
//}
//
//- (void)createPressureInitialState {
//}
//
//- (void)createTemplatureInitialState {
//}
//
//- (void)createDensity_ambInitialState {
//}

- (void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer {
    [_testCommand encodeWithCommandBuffer:_buffer outTexture:testSlab.dest];
    [testSlab swap];
    [self set_currentTexture:testSlab.source];
}
@synthesize _currentTexture;
@end
