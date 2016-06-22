//
//  ViewController.m
//  PlayRemote Video
//
//  Created by 闫振奎 on 15/10/10.
//  Copyright © 2015年 TowMen. All rights reserved.
//

#import "ViewController.h"
#import "ZKPlayerView.h"

@interface ViewController ()

@property (nonatomic, weak) ZKPlayerView *playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZKPlayerView *playerView = [ZKPlayerView playerView];
    [self.view addSubview:playerView];
    self.playerView = playerView;
    
    
    NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.playerView.playerItem = item;

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.playerView.frame = self.view.bounds;
}

@end
