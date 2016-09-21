//
//  XBProjectPath.h
//  XBPackTool
//
//  Created by 董玉毛 on 16/9/20.
//  Copyright © 2016年 dym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBProjectPath : NSObject
+ (instancetype)sharePProjectPath;

//获取项目路径
- (NSString*)projectPath;

//获取IPA路径
- (NSString*)projectIPAPath;

//获取build路径
- (NSString*)projectXcodeBuildPath:(NSString*)type;

//删除DerivedData文件夹下所有文件
+ (void)deleteDerivedDataSubFolder;


@end
