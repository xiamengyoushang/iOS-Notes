//
//  Person.m
//  iOS Test
//
//  Created by linkiing on 2018/6/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "Person.h"

static Person *person;
@implementation Person

+(id)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (person == nil) {
            person = [[Person alloc] init];
        }
    });
    return person;
}
- (id)init{
    if (self = [super init]) {}
    return self;
}

- (void)setName:(NSString *)name{
    _name = name;
}
- (NSString*)getName{
    return _name;
}

@end
