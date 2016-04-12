//
//  VoiceConverter.h
//  Jeans
//
//  Created by Jeans Huang on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VoiceConverter : NSObject

/**
 *  转换wav到mp3
 *
 *  @param aWavPath  wav文件路径
 *  @param aSavePath mp3保存路径
 *
 *  @return 0失败 1成功
 */
+ (int)ConvertWavToMp3:(NSString *)aWavPath mp3SavePath:(NSString *)aSavePath;
/**
	获取录音设置.
    建议使用此设置，如有修改，则转换amr时也要对应修改参数，比较麻烦
	@returns 录音设置
 */
+ (NSDictionary*)GetAudioRecorderSettingDict;

/**
 *  获取缓存路径
 *
 *  @return 缓存路径
 */
+ (NSString *)getCacheDirectory;

/**
 *  生成当前时间字符串
 */
+ (NSString *)getCurrentTimeString;
/**
 *  通过名字及类型获得文件路径
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 *
 *  @return 文件路径
 */
+ (NSString *)getPathFromFileName:(NSString *)fileName ofType:(NSString *)type;
@end
