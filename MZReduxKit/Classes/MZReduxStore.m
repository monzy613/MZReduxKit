//
//  MZReduxStore.m
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import "MZReduxStore.h"
#import "MZReduxState.h"

@implementation MZReduxStore

- (MZReduxState *)rootState {
    // Override this method to return a custom state
    return [MZReduxState new];
}

@end
