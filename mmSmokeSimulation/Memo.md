#Meta備忘録
##  MTLDeviceはクラスじゃない
MTLDeviceはSwiftだとクラスだが，Objectice-Cではプロトコル．
そのため，関数の引数や戻り値に設定するときはid<MTLDevice>とする．MTKViewはクラスで，こいつがMTLDeviceなどをメンバ変数に持っている．
## No visible @interface for 'interfaceName' declares the selector 'methodName'
不可視文字や，綴りミスによるバグ．2時間くらい持ってかれた．許さない．
