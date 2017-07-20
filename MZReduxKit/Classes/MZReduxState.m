//
//  MZReduxState.m
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import "MZReduxState.h"
#import "MZReduxPropertyUtil.h"

@implementation MZReduxState

#pragma mark - <NSCoding>
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSDictionary *propertyDictionary = [MZReduxPropertyUtil classPropsFor:[self class]];
        [propertyDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSDictionary *propertyDictionary = [MZReduxPropertyUtil classPropsFor:[self class]];
    [propertyDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }];
}

@end
