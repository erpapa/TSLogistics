//
//  AppDelegate.m
//  TSLogistics
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "AppDelegate.h"
#import "TSLNewfeatureViewController.h"
#import "UMCheckUpdate.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 2.1设置根控制器
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:CFBundleVersion];
    // 2.2获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[CFBundleVersion];
    if ([lastVersion isEqualToString:currentVersion]) {// 版本号相同
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = [storyboard instantiateInitialViewController];
    } else { //新特性
        self.window.rootViewController = [[TSLNewfeatureViewController alloc] init];
    }
    // 3.设置keyWindow并显示窗口
    [self.window makeKeyAndVisible];
    // 4.初始化shareSDK
    [self initShareSDK];
    // 5.初始化百度地图
    [self initBaiduMap];
    // 6.友盟更新
//    [UMCheckUpdate checkUpdate:@"发现新版本" cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即去更新" appkey:@"565fe2d967e58e4e4c00126c" channel:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

/**
 *  通过获取到的url，可以解析数据响应各种操作
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
/**
 *  初始化百度地图manager
 */
- (void)initBaiduMap
{
    self.mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [self.mapManager start:@"WmVNYdqTIpvCRIcRN1zoIEDi" generalDelegate:nil];
    if (!ret) {
        TSLog(@"manager start failed!");
    }
}
/**
 *  初始化shareSDK
 */
- (void)initShareSDK
{
    [ShareSDK registerApp:@"cc665e5cf1e7"];
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
}

@end
