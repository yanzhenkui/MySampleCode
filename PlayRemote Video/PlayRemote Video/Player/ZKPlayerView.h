//
//  ZKPlayerView.h
//  02-播放远程视频-封装播放器
//
//  Created by 王顺子 on 15/10/10.
//  Copyright © 2015年 闫振奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ZKPlayerViewDelegate <NSObject>

@optional
- (void)playerViewDidClickFullScreen:(BOOL)isFull;

@end

@interface ZKPlayerView : UIView

+ (instancetype)playerView;

@property (weak, nonatomic) id<ZKPlayerViewDelegate> delegate;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end
