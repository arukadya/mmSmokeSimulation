#ifndef ShaderTypes_h
#define ShaderTypes_h

#include <simd/simd.h>

typedef enum VertexInputIndex
{
    VertexInputIndexVertices     = 0,
    VertexInputIndexViewportSize = 1,
} VertexInputIndex;

typedef enum TextureIndex
{
    TextureIndexInput  = 0,
    TextureIndexOutput = 1,
} TextureIndex;

typedef struct
{
    // The position for the vertex, in pixel space; a value of 100 indicates 100 pixels
    // from the origin/center.
    vector_float2 position;

    // The 2D texture coordinate for this vertex.
    vector_float2 textureCoordinate;
} Vertex;

#endif /* AAPLShaderTypes_h */
