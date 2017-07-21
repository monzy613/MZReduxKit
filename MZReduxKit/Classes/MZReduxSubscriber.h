//
//  MZReduxSubscriber.h
//  Pods
//
//  Created by Monzy on 21/07/2017.
//
//

#import <Foundation/Foundation.h>

@class MZReduxState;

@protocol MZReduxSubscriber <NSObject>

- (void)updateState:(MZReduxState *)state;
- (Class)stateClass;

@end
