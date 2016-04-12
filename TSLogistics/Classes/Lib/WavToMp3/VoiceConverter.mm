//
//  VoiceConverter.mm
//  Jeans
//
//  Created by Jeans Huang on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VoiceConverter.h"
#import "lame.h"


@implementation VoiceConverter

//获取录音设置
+ (NSDictionary*)GetAudioRecorderSettingDict{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,//通道的数目
                                   //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
                                   //                                   [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
                                   //                                   [NSNumber numberWithInt: AVAudioQualityMedium],AVEncoderAudioQualityKey,//音频编码质量
                                   nil];
    return recordSetting;
}

+ (int)ConvertWavToMp3:(NSString *)aWavPath mp3SavePath:(NSString *)aSavePath
{
    int state = 0;
    @try {
        int read, write;
        
        FILE *pcm = fopen([aWavPath cStringUsingEncoding:NSASCIIStringEncoding], "rb");  //source
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([aSavePath cStringUsingEncoding:NSASCIIStringEncoding], "wb");  //output
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init(); // 初始化
        lame_set_num_channels(lame, 2); // 双声道
        lame_set_in_samplerate(lame, 8000); // 8k采样率
        lame_set_brate(lame, 16);  // 压缩的比特率为16
        lame_set_quality(lame, 2);  // mp3音质
        lame_init_params(lame);
        
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
        state = 1;
    }
    @catch (NSException *exception) {
        state = 0;
    }
    @finally {
        return state;
    }
}

#pragma mark - 通过名字及类型获得文件路径
/**
 *  通过名字及类型获得文件路径
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 *
 *  @return 文件路径
 */
+ (NSString *)getPathFromFileName:(NSString *)fileName ofType:(NSString *)type
{
    NSString *filePath = [[[self getCacheDirectory]stringByAppendingPathComponent:fileName]stringByAppendingPathExtension:type];
    NSFileManager *filemanager = [[NSFileManager alloc]init];
    if ([filemanager fileExistsAtPath:filePath]){ // 如果文件已存在，删除文件
        [filemanager removeItemAtPath:filePath error:NULL];
    }
    return filePath;
}

#pragma mark - 获得缓存路径
/**
 *  获取缓存路径
 *
 *  @return 缓存路径
 */
+ (NSString *)getCacheDirectory
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *voicePath = [cache stringByAppendingPathComponent:@"Voice"];
    NSFileManager *filemanager = [[NSFileManager alloc]init];
    if (![filemanager fileExistsAtPath:voicePath]){
        [filemanager createDirectoryAtPath:voicePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return voicePath;
}

#pragma mark - 生成当前时间字符串
+ (NSString *)getCurrentTimeString{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

@end
