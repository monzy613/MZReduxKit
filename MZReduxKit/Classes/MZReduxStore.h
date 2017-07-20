//
//  MZReduxStore.h
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import <Foundation/Foundation.h>

@class MZReduxState;

@interface MZReduxStore : NSObject

/**
 override this method to return a custom state

 @return MZReduxState
 */
- (MZReduxState *)rootState;

@end
