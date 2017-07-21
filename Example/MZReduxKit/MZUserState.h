//
//  MZUserState.h
//  MZReduxKit
//
//  Created by Monzy on 20/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import <MZReduxKit/MZReduxKit.h>

@interface MZUserState : MZReduxState

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *motto;

@end
