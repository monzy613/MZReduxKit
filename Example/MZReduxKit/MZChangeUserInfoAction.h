//
//  MZChangeUserInfoAction.h
//  MZReduxKit
//
//  Created by Monzy on 21/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import <MZReduxKit/MZReduxKit.h>

@interface MZChangeUserInfoAction : MZReduxAction

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *motto;

+ (instancetype)actionWithName:(NSString *)name motto:(NSString *)motto;

@end
