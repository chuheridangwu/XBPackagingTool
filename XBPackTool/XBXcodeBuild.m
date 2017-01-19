//
//  XBXcodeBuild.m
//  XBPackTool
//
//  Created by 董玉毛 on 16/9/20.
//  Copyright © 2016年 dym. All rights reserved.
//

#import "XBXcodeBuild.h"
#import "ProjectConfig.h"
#import "XBProjectPath.h"

@implementation XBXcodeBuild

+ (NSString *)xcodeBuildType:(XcodeBuildType)type{
    if (type == XcodeBuildType_Debug) {
        return  @"Debug";
    }else{
        return @"Release";
    }
}

+ (void)xcodeBuildProjectSetBuildType:(NSString*)buildType{
    
    // 删除项目之前build的文件夹
    [XBProjectPath deleteDerivedDataSubFolder];
    
    //切到项目目录
        NSString *cd = [NSString stringWithFormat:@"cd %@",XB_ProjectPath];
    
    // 1.清理工程
        NSString *clean = [NSString stringWithFormat:@"/usr/bin/xcodebuild -workspace %@.xcworkspace -scheme %@  clean",XB_ProjectName,XB_ProjectName];
    
    // 2.编译项目
        NSString *build = [NSString stringWithFormat:@"/usr/bin/xcodebuild -workspace %@.xcworkspace -scheme %@ -sdk iphoneos -configuration %@ build" ,XB_ProjectName,XB_ProjectName,buildType];
    
        NSString *shell1 = [NSString stringWithFormat:@"%@\n %@\n %@\n",cd,clean,build];
        system([shell1 cStringUsingEncoding:NSUTF8StringEncoding]);
    
    // 3.输出包
        NSString *run = [NSString stringWithFormat:@"/usr/bin/xcrun -sdk iphoneos PackageApplication -v %@",[[XBProjectPath sharePProjectPath] projectXcodeBuildPath:buildType]];
    
    // 4.上传到蒲公英
        NSString *upload = [NSString stringWithFormat:@"curl -F file=@%@ -F uKey=%@ -F _api_key=%@ http://www.pgyer.com/apiv1/app/upload",[NSString stringWithFormat:@"%@%@.ipa",XB_IPAPath,XB_ProjectName],XB_PgyerUserKey,XB_PgyerAPIKey];
  
    
    // 5.运行
        NSString *shell = [NSString stringWithFormat:@" %@\n %@\n",run,upload];
        system([shell cStringUsingEncoding:NSUTF8StringEncoding]);
}
@end
