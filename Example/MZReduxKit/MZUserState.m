//
//  MZUserState.m
//  MZReduxKit
//
//  Created by Monzy on 20/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import "MZUserState.h"
#import "MZChangeUserInfoAction.h"

@interface MZUserState ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *motto;

@end

@implementation MZUserState

+ (MZReduxState *)reducer:(MZReduxAction *)action state:(MZUserState *)state {
    if ([action isMemberOfClass:[MZChangeUserInfoAction class]]) {
        MZChangeUserInfoAction *anAction = (MZChangeUserInfoAction *)action;
        state.name = anAction.name;
        state.motto = anAction.motto;
    }
    return state;
}

@end
