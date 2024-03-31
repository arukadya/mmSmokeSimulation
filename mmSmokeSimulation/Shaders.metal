/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Metal shaders used for this sample
*/

#include <metal_stdlib>

using namespace metal;

#import "ShaderTypes.h"

struct RasterizerData
{
    float4 clipSpacePosition [[position]];
    float2 textureCoordinate;

};

// Vertex Function
vertex RasterizerData
vertexShader(uint                   vertexID             [[ vertex_id ]],
             constant Vertex   *vertexArray          [[ buffer(VertexInputIndexVertices) ]],
             constant vector_uint2 *viewportSizePointer  [[ buffer(VertexInputIndexViewportSize) ]])

{

    RasterizerData out;

    // Index into the array of positions to get the current vertex
    // Positions are specified in pixel dimensions (i.e. a value of 100 is 100 pixels from
    // the origin)
    float2 pixelSpacePosition = vertexArray[vertexID].position.xy;

    float2 viewportSize = float2(*viewportSizePointer);

    // convert the pixel positions into normalized device coordinates.
    
    // The output position of every vertex shader is in clip space (also known as normalized device
    //   coordinate space, or NDC).   A value of (-1.0, -1.0) in clip-space represents the
    //   lower-left corner of the viewport whereas (1.0, 1.0) represents the upper-right corner of
    //   the viewport.

    // In order to convert from positions in pixel space to positions in clip space, divide the
    //   pixel coordinates by half the size of the viewport.
    out.clipSpacePosition.xy = pixelSpacePosition / (viewportSize / 2.0);
    out.clipSpacePosition.z = 0.0;
    out.clipSpacePosition.w = 1.0;

    // Pass the input textureCoordinate straight to the output RasterizerData.  This value will be
    //   interpolated with the other textureCoordinate values in the vertices that make up the
    //   triangle.
    out.textureCoordinate = vertexArray[vertexID].textureCoordinate;

    return out;
}

// Fragment function
fragment float4 samplingShader(RasterizerData  in           [[stage_in]],
                               texture2d<half> colorTexture [[ texture(TextureIndexOutput) ]])
{
    constexpr sampler textureSampler (mag_filter::linear,
                                      min_filter::linear);

    // Sample the texture and return the color to colorSample
    const half4 colorSample = colorTexture.sample (textureSampler, in.textureCoordinate);
    return float4(colorSample);
}

// Rec. 709 luma values for grayscale image conversion
constant half3 kRec709Luma = half3(0.2126, 0.7152, 0.0722);

// Grayscale compute kernel
kernel void simasima(texture2d<float, access::write> outTexture [[texture(0)]],
                     uint2                          gid        [[thread_position_in_grid]]){
    float4 newValue;
    if(( gid.x / 10) % 2 == 1){newValue = {1.0,1.0,1.0,1.0};}
    else newValue = {0.0,0.0,0.0,1.0};
    outTexture.write(newValue, gid);
}


