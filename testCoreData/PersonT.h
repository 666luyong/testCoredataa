//
//  PersonT.h
//  testCoreData
//
//  Created by luyong on 16/7/24.
//  Copyright © 2016年 BEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonT : NSValueTransformer
@property(nonatomic, strong)NSNumber *age;
@property(nonatomic, copy)NSString *name;
@end
