//
//  ZXLUploadTaskModel.m
//  Compass
//
//  Created by 张小龙 on 2018/4/8.
//  Copyright © 2018年 ZXL. All rights reserved.
//

#import "ZXLUploadTaskModel.h"
#import <ZXLUtilsDefined.h>

#import <ZXLUpload/ZXLUploadDefine.h>
#import <ZXLUpload/ZXLTaskInfoModel.h>
#import <ZXLUpload/ZXLUploadTaskManager.h>

@implementation ZXLUploadTaskModel
+(instancetype)dictionary:(NSDictionary *)dictionary{
    return [[[self class] alloc] initWithDictionary:dictionary];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        self.taskTid             =  [dictionary objectForKey:@"taskTid"];
        self.taskName            =  [dictionary objectForKey:@"taskName"];
        self.taskImageURL        =  [dictionary objectForKey:@"taskImageURL"];
        self.content             =  [dictionary objectForKey:@"content"];
        self.uploadIdentifier    =  [dictionary objectForKey:@"uploadIdentifier"];
    }
    return self;
}

-(ZXLTaskInfoModel *)getUploadTaskInfo{
    if (!ZXLUtilsISNSStringValid(self.uploadIdentifier)) return nil;
    return [[ZXLUploadTaskManager manager] uploadTaskInfoForIdentifier:self.uploadIdentifier];
}

- (float)uploadProgress{
    ZXLTaskInfoModel *uploadTask = [self getUploadTaskInfo];
    if (uploadTask) {
        return [uploadTask uploadProgress];
    }
    return 0;
}

- (float)compressProgress{
    ZXLTaskInfoModel *uploadTask = [self getUploadTaskInfo];
    if (uploadTask) {
        return [uploadTask compressProgress];
    }
    return 0;
}

- (ZXLUploadTaskType)uploadTaskType{
    ZXLTaskInfoModel *uploadTask = [self getUploadTaskInfo];
    if (uploadTask) {
        return [uploadTask uploadTaskType];
    }
    return ZXLUploadTaskPrepareForUpload;
}

- (long long)uploadFileSize{
    ZXLTaskInfoModel *uploadTask = [self getUploadTaskInfo];
    if (uploadTask) {
        return [uploadTask uploadFileSize];
    }
    return 0;
}
@end
