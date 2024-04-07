//
//  InitializeTexture.metal
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/06.
//

#include <metal_stdlib>
using namespace metal;

bool isInside(int x,int y,uint2 center,int width,int height){
    int lx = center.x - width/2;
    int rx = center.x + width/2;
    int dy = center.y - width/2;
    int uy = center.y + width/2;
    if( (lx < x && x < rx) &&
       (dy < y && y < uy))return true;
    else return false;
}
kernel void initializeUniform(texture2d<float, access::write> outTexture [[texture(0)]],constant float &value[[buffer(0)]],
    uint2 gid[[thread_position_in_grid]]){
    float _value = value;
    outTexture.write(_value, gid);
}
kernel void initializeWithArea(texture2d<float, access::write> outTexture [[texture(0)]],constant float &value[[buffer(0)]],
    uint2 gid[[thread_position_in_grid]]){
    float _value = value;
    uint2 textureSize = ((unsigned int)outTexture.get_width(), (unsigned int)outTexture.get_height());
    uint2 center = uint2(textureSize.x/2, textureSize.y/2);
    int width = textureSize.x/2;
    int height = textureSize.y/2;
    if(isInside(gid.x, gid.y,center,width,height))outTexture.write(value, gid);
    else outTexture.write(0, gid);
}
