//
//  CPTableGroup.m
//  CPDataCenter
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "CPTableGroup.h"
#import "CPTableGroupRecord.h"

@implementation CPTableGroup

#pragma mark - CTPersistanceTableProtocol
- (NSString *)tableName
{
    return @"group";
}

- (NSString *)databaseName
{
    return @"CPDatabase.sqlite";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"primaryKey":@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
             @"name":@"TEXT",
             };
}

- (Class)recordClass
{
    return [CPTableGroupRecord class];
}

- (NSString *)primaryKeyName
{
    return @"primaryKey";
}

@end
