//
//  MZReduxState.h
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import <Foundation/Foundation.h>

@class MZReduxAction;
@interface MZReduxState : NSObject <NSCoding>

/**
 override this method in subclass

 @param action Action
 @param state State
 @return MZReduxState
 */
+ (MZReduxState *)reducer:(MZReduxAction *)action state:(MZReduxState *)state;

@end
