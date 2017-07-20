//
//  MZReduxAction.h
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import <Foundation/Foundation.h>

@class MZReduxPayload;

@interface MZReduxAction : NSObject

@property (nonatomic, strong) MZReduxPayload *payload;

@end
