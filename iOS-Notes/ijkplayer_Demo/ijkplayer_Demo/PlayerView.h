//
//  PlayerView.h
//  RTSP Stream
//
//  Created by linkiing on 2018/5/2.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface PlayerView : UIView

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, weak) UIView *playerView;
@property (nonatomic, retain) id <IJKMediaPlayback> mediaPlayer;

@end
