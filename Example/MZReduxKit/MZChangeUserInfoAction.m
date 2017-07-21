//
//  MZChangeUserInfoAction.m
//  MZReduxKit
//
//  Created by Monzy on 21/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import "MZChangeUserInfoAction.h"

@implementation MZChangeUserInfoAction

+ (instancetype)actionWithName:(NSString *)name motto:(NSString *)motto {
    MZChangeUserInfoAction *action = [MZChangeUserInfoAction new];
    action.name = name;
    action.motto = motto;
    return action;
}

@end
