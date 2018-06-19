//
//  Person.h
//  iOS Test
//
//  Created by linkiing on 2018/6/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

//单例
+(id)shareInstance;

@property (nonatomic, strong) NSString *name;

@end
