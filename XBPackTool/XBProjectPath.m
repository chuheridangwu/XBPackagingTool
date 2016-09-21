//
//  XBProjectPath.m
//  XBPackTool
//
//  Created by 董玉毛 on 16/9/20.
//  Copyright © 2016年 dym. All rights reserved.
//

#import "XBProjectPath.h"
#import "ProjectConfig.h"

@implementation XBProjectPath
+ (instancetype)sharePProjectPath{
    static XBProjectPath *path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = [[XBProjectPath alloc]init];
    });
    return path;
}

- (NSString*)projectPath{
    return XB_ProjectPath;
}

- (NSString*)projectIPAPath{
    return XB_IPAPath;
}

- (NSString*)projectXcodeBuildPath:(NSString*)type{
        NSString *path ;
    
        NSArray *fileArr = [XBProjectPath getUserXcodeBuildPath];
        for (NSString *filePath in fileArr) {
            if ([filePath rangeOfString:[NSString stringWithFormat:@"%@",XB_ProjectName]].location != NSNotFound) {
                path  = [[XBProjectPath getUserXcodeDerivedDataPath] stringByAppendingString:[NSString stringWithFormat:@"/%@/Build/Products/%@-iphoneos/%@.app -o %@/%@.ipa",filePath,type,XB_ProjectName,XB_IPAPath,XB_ProjectName]];
                NSLog(@"%@---",path);
                return path;
            }
        }
    return path;
}


//删除DerivedData文件夹下所有文件
+ (void)deleteDerivedDataSubFolder{
    NSArray *fileArr = [XBProjectPath getUserXcodeBuildPath];
    
        for (NSString *filePath in fileArr) {
            if ([filePath rangeOfString:[NSString stringWithFormat:@"%@",XB_ProjectName]].location != NSNotFound) {
                NSString *path  = [[XBProjectPath getUserXcodeDerivedDataPath] stringByAppendingPathComponent:filePath];
                NSString *shell = [NSString stringWithFormat:@"rm -rf %@",path];
                system([shell cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        }
}

+ (NSArray*)getUserXcodeBuildPath{
    NSArray *fileArr = [NSArray array];
    NSFileManager * fm = [NSFileManager defaultManager];
    fileArr = [fm contentsOfDirectoryAtPath:[XBProjectPath getUserXcodeDerivedDataPath] error:nil];
    return fileArr;
}

+ (NSString*)getUserXcodeDerivedDataPath{
    NSString *filePath = @"";
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    NSArray *cepationArr = [bundlePath componentsSeparatedByString:@"DerivedData"];
    if (cepationArr.count != 0) {
        filePath = [[cepationArr firstObject] stringByAppendingString:@"DerivedData"];
        [XBProjectPath certificatePathIn:filePath];
    }
    return filePath;
}


+ (void)certificatePathIn:(NSString *)projectPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSAssert([fileManager fileExistsAtPath:projectPath], @"无效的地址");
}

@end
