//
//  InitializeTexture.metal
//  mmSmokeSimulation
//
//  Created by 須之内俊樹 on 2024/04/06.
//

#include <metal_stdlib>
using namespace metal;


struct InitializeArea{
    uint2 _center;
    int _width;
    int _height;
    InitializeArea(int width,int height,uint2 center){
        _center = center;
        _width = width;
        _height = height;
    }
    bool isInside(int x,int y){
        int lx = _center.x - _width/2;
        int rx = _center.x + _width/2;
        int dy = _center.y - _width/2;
        int uy = _center.y + _width/2;
        if( (lx < x && x < rx) &&
           (dy < y && y < uy))return true;
        else return false;
    }
};

kernel void initializeUniform(texture2d<float, access::write> outTexture [[texture(0)]],constant float &value,
                     uint2                          gid        [[thread_position_in_grid]]){
    outTexture.write(value, gid);
}
kernel void initializeWithArea(texture2d<float, access::write> outTexture [[texture(0)]],constant float &value,
                     uint2                          gid        [[thread_position_in_grid]]){
    uint2 center = uint2(outTexture.get_width()/2, outTexture.get_height()/4);
    InitializeArea initArea = InitializeArea(outTexture.get_width()/2, outTexture.get_height()/2, center);
    if(initArea.isInside(gid.x, gid.y))outTexture.write(value, gid);
    else outTexture.write(0, gid);
    
}
