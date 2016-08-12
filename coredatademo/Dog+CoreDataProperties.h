//
//  Dog+CoreDataProperties.h
//  coredatademo
//
//  Created by yong on 16/8/5.
//  Copyright © 2016年 iosYong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dog (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *sex;

@end

NS_ASSUME_NONNULL_END
