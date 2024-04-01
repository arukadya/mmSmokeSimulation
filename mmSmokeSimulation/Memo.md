#Meta備忘録
##  MTLDeviceはクラスじゃない
MTLDeviceはSwiftだとクラスだが，Objectice-Cではプロトコル．
そのため，関数の引数や戻り値に設定するときはid<MTLDevice>とする．MTKViewはクラスで，こいつがMTLDeviceなどをメンバ変数に持っている．
