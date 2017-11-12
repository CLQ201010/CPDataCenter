//
//  CPTableItem.m
//  CPDataCenter
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "CPTableItem.h"
#import "CPTableItemRecord.h"

@implementation CPTableItem

#pragma mark - CTPersistanceTableProtocol
- (NSString *)tableName
{
    return @"record";
}

- (NSString *)databaseName
{
    return @"CPDatabase.sqlite";
}

- (NSDictionary *)columnInfo
{
    return @{
             @"primaryKey":@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
             @"title":@"TEXT",
             @"content":@"TEXT",
             @"groupid":@"INTEGER",
             };
}

- (Class)recordClass
{
    return [CPTableItemRecord class];
}

- (NSString *)primaryKeyName
{
    return @"primaryKey";
}

@end
