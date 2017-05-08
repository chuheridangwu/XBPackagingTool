//
//  main.m
//  XBPackTool
//
//  Created by dym on 16/8/29.
//  Copyright © 2016年 dym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBXcodeBuild.h"




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //打包程序
        [XBXcodeBuild xcodeBuildProjectSetBuildType:[XBXcodeBuild xcodeBuildType:XcodeBuildType_Debug]];
        
        
    }
    return 0;
}
























