//
//  MZReduxReducer.h
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import <Foundation/Foundation.h>

@class MZReduxAction, MZReduxState;
@interface MZReduxReducer : NSObject


/**
 Override this method in subclass of MZRedux Reducer

 @param action Action
 @param state State
 @return MZReduxState
 */
+ (MZReduxState *)reducer:(MZReduxAction *)action state:(MZReduxState *)state;

@end
