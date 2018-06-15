//
//  PlayerView.m
//  RTSP Stream
//
//  Created by linkiing on 2018/5/2.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "PlayerView.h"
//https://blog.csdn.net/xihuandiannao/article/details/78328723
//https://www.jianshu.com/p/622713b446a2

@implementation PlayerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
}
- (void)setUrl:(NSURL *)url{
    _url = url;
    //https://www.jianshu.com/p/810da6aea58f
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    //设置最大帧和帧速率
    [options setPlayerOptionIntValue:30  forKey:@"max-fps"];
    [options setPlayerOptionIntValue:20 forKey:@"r"];
    //跳帧开关
    [options setPlayerOptionIntValue:1  forKey:@"framedrop"];
    [options setPlayerOptionIntValue:0  forKey:@"start-on-prepared"];
    [options setPlayerOptionIntValue:0  forKey:@"http-detect-range-support"];
    [options setPlayerOptionIntValue:48  forKey:@"skip_loop_filter"];
    [options setPlayerOptionIntValue:0  forKey:@"packet-buffering"];
    [options setPlayerOptionIntValue:2000000 forKey:@"analyzeduration"];
    [options setPlayerOptionIntValue:25  forKey:@"min-frames"];
    [options setPlayerOptionIntValue:1  forKey:@"start-on-prepared"];
    [options setCodecOptionIntValue:8 forKey:@"skip_frame"];
    [options setFormatOptionValue:@"nobuffer" forKey:@"fflags"];
    [options setFormatOptionValue:@"8192" forKey:@"probsize"];
    //自动转屏开关
    [options setFormatOptionIntValue:0 forKey:@"auto_convert"];
    //重连次数
    [options setFormatOptionIntValue:1 forKey:@"reconnect"];
    //开启硬解码
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    
    _mediaPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options];
    
    UIView *displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _playerView = displayView;
    _playerView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.playerView];
    
    UIView *mediaView = [_mediaPlayer view];
    mediaView.frame = self.playerView.bounds;
    mediaView.backgroundColor = [UIColor blackColor];
    [_playerView insertSubview:mediaView atIndex:1];
    [_mediaPlayer setScalingMode:IJKMPMovieScalingModeAspectFill];
    if (![_mediaPlayer isPlaying]) {
        [_mediaPlayer prepareToPlay];
    }
    
    UIView *borderView = [UIView new];
    borderView.layer.borderWidth = 1;
    borderView.layer.borderColor = [UIColor whiteColor].CGColor;
    borderView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:borderView];
}

@end
