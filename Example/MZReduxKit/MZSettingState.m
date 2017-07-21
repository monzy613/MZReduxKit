//
//  MZSettingState.m
//  MZReduxKit
//
//  Created by Monzy on 21/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import "MZSettingState.h"
#import "MZChangeNotificationStateAction.h"

@interface MZSettingState ()

@property (nonatomic, assign) BOOL isNotificationOn;

@end

@implementation MZSettingState

+ (MZReduxState *)reducer:(MZReduxAction *)action state:(MZSettingState *)state {
    if ([action isMemberOfClass:[MZChangeNotificationStateAction class]]) {
        MZChangeNotificationStateAction *anAction = (MZChangeNotificationStateAction *)action;
        if (anAction.isOn != state.isNotificationOn) {
            state.isNotificationOn = anAction.isOn;
        }
        return state;
    }
    return state;
}

@end
