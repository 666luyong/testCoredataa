//
//  PersonT.m
//  testCoreData
//
//  Created by luyong on 16/7/24.
//  Copyright © 2016年 BEN. All rights reserved.
//

#import "PersonT.h"

@implementation PersonT

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value {
    return [[UIImage alloc] initWithData:value];
}
@end
