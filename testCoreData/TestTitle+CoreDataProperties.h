//
//  TestTitle+CoreDataProperties.h
//  testCoreData
//
//  Created by luyong on 16/7/24.
//  Copyright © 2016年 BEN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TestTitle.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestTitle (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) id person;

@end

NS_ASSUME_NONNULL_END
