#import "Renderer.h"
#import <Eigen/Core>
#import <iostream>
#import "DebugCommand.h"

struct RenderArea{
    int size = 500;
    Eigen::Vector2f leftdown = {-size,-size};
    Eigen::Vector2f leftup = {-size,size};
    Eigen::Vector2f rightdown = {size,-size};
    Eigen::Vector2f rightup = {size,size};
};

// Main class performing the rendering
@implementation Renderer
{
    RenderArea renderArea;
    id<MTLDevice> _device;
    id<MTLComputePipelineState> _computePipelineState;
    id<MTLRenderPipelineState> _renderPipelineState;
    
    id<MTLRenderPipelineState> _pipelineState;
    id<MTLCommandQueue> _commandQueue;
    vector_uint2 _viewportSize;
    id<MTLTexture> _outputTexture;
    Slab *testSlab;
    MTLSize _threadgroupSize;
    MTLSize _threadgroupCount;
    testCommand *_testCommand;
    ShaderBase *_shaderBase;
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView
{
    self = [super init];
    if(self)
    {
        NSError *error = NULL;

        _device = mtkView.device;

        mtkView.colorPixelFormat = MTLPixelFormatBGRA8Unorm_sRGB;

        // Load all the shader files with a .metal file extension in the project.
        id<MTLLibrary> defaultLibrary = [_device newDefaultLibrary];
        
        // pipeline.
        id<MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName:@"vertexShader"];
        id<MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName:@"samplingShader"];

        MTLRenderPipelineDescriptor *pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        pipelineStateDescriptor.label = @"Simple Render Pipeline";
        pipelineStateDescriptor.vertexFunction = vertexFunction;
        pipelineStateDescriptor.fragmentFunction = fragmentFunction;
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat;

        _renderPipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineStateDescriptor
                                                                 error:&error];

        NSAssert(_renderPipelineState, @"Failed to create render pipeline state: %@", error);

//        MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
//        textureDescriptor.textureType = MTLTextureType2D;
//        textureDescriptor.pixelFormat = MTLPixelFormatBGRA8Unorm;
//        textureDescriptor.pixelFormat = MTLPixelFormatRGBA32Float;

//        textureDescriptor.width = 256;
//        textureDescriptor.height = 256;
        
//        textureDescriptor.usage = MTLTextureUsageShaderWrite | MTLTextureUsageShaderRead ;
//        _outputTexture = [_device newTextureWithDescriptor:textureDescriptor];
        
//        _threadgroupSize = MTLSizeMake(16, 16, 1);
//        _threadgroupCount.width  = (_outputTexture.width  + _threadgroupSize.width -  1) / _threadgroupSize.width;
//        _threadgroupCount.height = (_outputTexture.height + _threadgroupSize.height - 1) / _threadgroupSize.height;
        // The image data is 2D, so set depth to 1.
//        _threadgroupCount.depth = 1;

        // Create the command queue.
        _commandQueue = [_device newCommandQueue];
        testSlab = [[Slab alloc] makeSlabWithView:mtkView :256 :256 :1];
        _testCommand = [[testCommand alloc] initWithDevice:_device functionName:@"simasima"];
        
    }
    return self;
}

/// Called whenever view changes orientation or is resized
- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    // Save the size of the drawable to pass to the vertex shader.
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

/// Called whenever the view needs to render a frame.
- (void)drawInMTKView:(nonnull MTKView *)view
{
    static const Vertex quadVertices[] =
    {
        // Pixel positions, Texture coordinates
        { {  renderArea.rightdown.x(), renderArea.rightdown.y()  },  { 1.f, 1.f } },
        { {  renderArea.leftdown.x(), renderArea.leftdown.y()},  { 0.f, 1.f } },
        { {  renderArea.leftup.x(),   renderArea.leftup.y() },  { 0.f, 0.f } },

        { {  renderArea.rightdown.x(), renderArea.rightdown.y()  },  { 1.f, 1.f } },
        { {  renderArea.leftup.x(),   renderArea.leftup.y() },  { 0.f, 0.f } },
        { {  renderArea.rightup.x(),   renderArea.rightup.y() },  { 1.f, 0.f } },
    };

    // Create a new command buffer for each frame.
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    
    [_testCommand encodeWithCommandBuffer:commandBuffer outTexture:testSlab.dest];

    [testSlab swap];
    // Use the output image to draw to the view's drawable texture.
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    if(renderPassDescriptor != nil)
    {
        // Create the encoder for the render pass.
        id<MTLRenderCommandEncoder> renderEncoder =
        [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"MyRenderEncoder";

        // Set the region of the drawable to draw into.
        [renderEncoder setViewport:(MTLViewport){0.0, 0.0, static_cast<double>(_viewportSize.x), static_cast<double>(_viewportSize.y), -1.0, 1.0 }];

        [renderEncoder setRenderPipelineState:_renderPipelineState];

        // Encode the vertex data.
        [renderEncoder setVertexBytes:quadVertices
                               length:sizeof(quadVertices)
                              atIndex:VertexInputIndexVertices];

        // Encode the viewport data.
        [renderEncoder setVertexBytes:&_viewportSize
                               length:sizeof(_viewportSize)
                              atIndex:VertexInputIndexViewportSize];

        // Encode the output texture from the previous stage.
//        [renderEncoder setFragmentTexture:_outputTexture
//                                  atIndex:TextureIndexOutput];
        [renderEncoder setFragmentTexture:testSlab.dest atIndex:TextureIndexOutput];

        // Draw the quad.
        [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle
                          vertexStart:0
                          vertexCount:6];

        [renderEncoder endEncoding];

        // Schedule a present once the framebuffer is complete using the current drawable.
        [commandBuffer presentDrawable:view.currentDrawable];
    }

    [commandBuffer commit];
}

@end
