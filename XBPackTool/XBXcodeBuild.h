//
//  XBXcodeBuild.h
//  XBPackTool
//
//  Created by 董玉毛 on 16/9/20.
//  Copyright © 2016年 dym. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    XcodeBuildType_Debug,
    XcodeBuildType_Release
}XcodeBuildType;

@class XBProjectEntity;
@interface XBXcodeBuild : NSObject
+ (NSString *)xcodeBuildType:(XcodeBuildType)type;
+ (void)xcodeBuildProjectSetBuildType:(NSString*)buildType;
@end
