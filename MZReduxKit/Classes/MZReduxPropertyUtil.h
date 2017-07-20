//
//  MZReduxPropertyUtil.h
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import <Foundation/Foundation.h>

@interface MZReduxPropertyUtil : NSObject


/**
 return a dictionary of the properties of a specified class

 @param klass the class
 @return dictionary of the properties of a specified class
 */
+ (NSDictionary *)classPropsFor:(Class)klass;

@end
