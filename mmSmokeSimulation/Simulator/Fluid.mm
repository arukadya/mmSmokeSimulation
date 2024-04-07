//
//  Fluid.m
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/04.
//

#import <Foundation/Foundation.h>
#import "Fluid.h"
#import <iostream>
static int kDencityComponent = 1;
static int kForceComponent = 4;
static float kAmbientTemprature = 25.0;
static float kTimeStep = 0.1;
static float kDensityInitialValue =  200.0;
static float kTempratureInitialValue =  100.0;
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
    TextureInitializer *_textureInitializerUniform;
    TextureInitializer *_textureInitializerWithArea;
    AddForce *_xAddforce;
    AddForce *_yAddforce;
    CalForce *_calForce;
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
    _force = [[Slab alloc] makeSlabWithDevice:_device :_width :_height :2];
    
    _textureInitializerUniform = [[TextureInitializer alloc] initWithDevice:_device functionName:@"initializeUniform" value:0.0];
    _textureInitializerWithArea = [[TextureInitializer alloc] initWithDevice:_device functionName:@"initializeWithArea" value:0.0];
    _xAddforce = [[AddForce alloc] initWithDevice:_device functionName:@"xAddForce" timeStep:kTimeStep];
    _yAddforce = [[AddForce alloc] initWithDevice:_device functionName:@"yAddForce" timeStep:kTimeStep];
    _calForce = [[CalForce alloc] initWithDevice:_device kTemprature_amb:kAmbientTemprature];
    
//    testSlab = [[Slab alloc] makeSlabWithDevice:_device :256 :256 :1];
//    _testCommand = [[testCommand alloc] initWithDevice:_device functionName:@"simasima"];
    
    //initialize uniform(velocity pressure density_amb force)
    [_textureInitializerUniform encodeWithCommandBuffer:_buffer outTexture:_xVelocity.source];
    [_textureInitializerUniform encodeWithCommandBuffer:_buffer outTexture:_yVelocity.source];
    [_textureInitializerUniform encodeWithCommandBuffer:_buffer outTexture:_pressure.source];
    [_textureInitializerUniform encodeWithCommandBuffer:_buffer outTexture:_density_amb.source];
    [_textureInitializerUniform encodeWithCommandBuffer:_buffer outTexture:_force.source];
    //initialize with area(density,templature)
    [_textureInitializerWithArea set_value:kTempratureInitialValue];
    [_textureInitializerWithArea encodeWithCommandBuffer:_buffer outTexture:_templature.source];
    [_textureInitializerWithArea set_value:kDensityInitialValue];
    [_textureInitializerWithArea encodeWithCommandBuffer:_buffer outTexture:_density.source];
    [_buffer commit];
    [self set_currentTexture:_force.source];
    return self;
}

- (void)encodeWithCommandBuffer:(nonnull id<MTLCommandBuffer>)_buffer {
//    [_textureInitializerWithArea set_value:kDensityInitialValue];
//    [_textureInitializerWithArea encodeWithCommandBuffer:_buffer outTexture:_density.source];
//    [_textureInitializerWithArea set_value:kTempratureInitialValue];
//    [_textureInitializerWithArea encodeWithCommandBuffer:_buffer outTexture:_templature.source];
//    [_testCommand encodeWithCommandBuffer:_buffer outTexture:testSlab.dest];
//    [testSlab swap];
    [_calForce encodeWithCommandBuffer:_buffer outForceTexture:_force.dest densityTexture:_density.source density_ambTexture:_density_amb.source tempratureTexture:_templature.source];
    [_force swap];
    [_xAddforce encodeWithCommandBuffer:_buffer inVelocityTexture:_xVelocity.source outVelocityTexture:_xVelocity.dest forceTexture:_force.source];
    
    
}
@synthesize _currentTexture;
@end
