//
//  ViewController.m
//  ijkplayer_Demo
//
//  Created by linkiing on 2018/5/25.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "ViewController.h"
#import "PlayerView.h"

#define RTSP_STREAM_Default1    @"rtsp://192.168.1.30/stream1s"
#define VIDEO_STEAM_Default1    @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - ijkplayer视频流
- (void)ijkplayer_Initialize{
    NSArray *urlArray = [NSArray arrayWithObjects:RTSP_STREAM_Default1,VIDEO_STEAM_Default1, nil];
    for (NSInteger i=0; i<2; i++) {
        PlayerView *playerview = [self.view viewWithTag:1000+i];
        playerview.url = [NSURL URLWithString:[urlArray objectAtIndex:i]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ijkplayer_Initialize];
}

@end
