## 根据当前网络状态利用SDWebImage加载高清图或者缩略图

### 一、整体思路（伪代码）

	
	


```
概述总结:

- (void)SDWebImage{
    
    if (缓存中有高清原图) {
        设置高清原图
    }else{
        if (在WiFi环境下) {
            下载显示原图
        }else if{ //蜂窝移动网络
            if (3G或4G环境) {
                使用SDWebImage下载显示原图
            }else{ //2G网络
                下载显示小图
            }
            
        }else{ //没有网络
            if (内存/沙盒缓存中有小图) {
                显示小图
            }else{
                显示占位图片
            }
        }
    }
    
}

疑点说明：
	// 1.SDWebImage在下载图片时,首先会关闭imageView当前的下载任务
	// 2.SDWebImage在下载图片时,会优先使用缓存而不是直接下载
	// 3.可以在头像的imageView利用 sd_setImageWithURL: placeholderImage: options:方法，在options中填入只缓存内存或者不缓存。特殊情况特殊处理
    

```
	
### 二、实现相应方法
 - 0.在自己封装的下载图片请求工具类中实现，设置图片之前，根据当前网络环境去加载对应图片；

 - 1.在.h文件中
 
```
#import <UIImageView+WebCache.h>

// 定义回调block
typedef void(^SDWebImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);
typedef void(^SDWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);


/**
 *  根据具体网络状态加载图片
 *
 *  @param OriginalImageUrlStr  高清大图的Url
 *  @param thumbnailImageUrlStr 缩略图的Url
 *  @param placeholder          占位图片
 *  @param progressBlock        下载进度
 *  @param completedBlock       完成回调
 *  @param imageView            要给那个控件设置图片
 */
+ (void)zk_setImageWithOriginalImageUrlStr:(NSString *)OriginalImageUrlStr thumbnailImageUrlStr:(NSString *)thumbnailImageUrlStr placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock imageView:(UIImageView *)imageView;
```

 - 2.在.m文件中
 
 ```
 #import <AFNetworking/AFNetworking.h>
 
 /******根据网络状态加载图片******/
+ (void)zk_setImageWithOriginalImageUrlStr:(NSString *)OriginalImageUrlStr thumbnailImageUrlStr:(NSString *)thumbnailImageUrlStr placeholderImage:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock imageView:(UIImageView *)imageView
{
    // 从内存\沙盒缓存中获得原图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:OriginalImageUrlStr];
    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
        [imageView sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrlStr] placeholderImage:placeholder];
    } else { // 内存\沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
            [imageView sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrlStr] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
            //     用户的配置项假设利用NSUserDefaults存储到了沙盒中
            //    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
            //    [[NSUserDefaults standardUserDefaults] synchronize];
//  `从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图`
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
            if (alwaysDownloadOriginalImage) { // 下载原图
                [imageView sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrlStr] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
            } else { // 下载小图
                [imageView sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrlStr] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
            }
        } else { // 没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageUrlStr];
            if (thumbnailImage) { // 内存\沙盒缓存中有小图
                [imageView sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrlStr] placeholderImage:placeholder];
            } else {
                [imageView sd_setImageWithURL:nil placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
            }
        }
    }
}

 ```
### 三、使用场景


####自定义的UITableViewCell上有图片需要显示，要求网络网络状态为WiFi时，显示图片高清图；网络状态为蜂窝移动网络时，显示图片缩略图，没有网络时，先查看缓存中是否有高清原图，如果没有再查看当前是否在WiFi环境下，如果没有再查看当前是否是3G、4G，如果还没有再查看当前是否是2G




