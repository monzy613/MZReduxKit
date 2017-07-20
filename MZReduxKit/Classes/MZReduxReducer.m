//
//  MZReduxReducer.m
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import "MZReduxReducer.h"

@implementation MZReduxReducer

- (MZReduxState *)reducer:(MZReduxAction *)action state:(MZReduxState *)state {
    // override this method in subclass of MZRedux Reducer
    return state;
}

@end
