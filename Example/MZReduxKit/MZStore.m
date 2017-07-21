//
//  MZStore.m
//  MZReduxKit
//
//  Created by Monzy on 21/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import "MZStore.h"
#import "MZUserState.h"
#import "MZSettingState.h"

@implementation MZStore

+ (instancetype)sharedStore {
    static MZStore *_sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStore = [MZStore storeWithStates:@[
                                                  [MZUserState new],
                                                  [MZSettingState new]
                                                  ]];
    });

    return _sharedStore;
}

@end
