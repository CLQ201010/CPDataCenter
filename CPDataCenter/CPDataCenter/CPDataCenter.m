//
//  CPDataCenter.m
//  CPDataCenter
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "CPDataCenter.h"
#import "CPTableItem.h"
#import "CPTableItemRecord.h"
#import "CPTableGroup.h"
#import "CPTableGroupRecord.h"

@interface CPDataCenter ()

@property (nonatomic, strong) CPTableGroup *groupTable;
@property (nonatomic, strong) CPTableItem *itemTable;

@end

@implementation CPDataCenter

#pragma mark - init
- (instancetype)initWithSecretKey:(NSString *)secretKey
{
    self = [super init];
    if (self) {
        [[NSUserDefaults standardUserDefaults] setObject:secretKey forKey:@"CPDatabaseSecretKey"];
    }
    return self;
}

#pragma mark - group
- (NSArray <NSDictionary *> *)groupList
{
    NSError *error = nil;
    NSArray <NSObject <CTPersistanceRecordProtocol> *> *groupRecordList = [self.groupTable findAllWithError:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    NSMutableArray *groupList = [[NSMutableArray alloc] init];
    for (NSObject <CTPersistanceRecordProtocol> *record in groupRecordList) {
        [groupList addObject:[record dictionaryRepresentationWithTable:self.groupTable]];
    }
    return groupList;
}

- (NSDictionary *)addGroup:(NSString *)groupName
{
    CPTableGroupRecord *record = [[CPTableGroupRecord alloc] init];
    record.name = groupName;
    
    NSError *error = nil;
    [self.groupTable insertRecord:record error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return [record dictionaryRepresentationWithTable:self.groupTable];
}

- (NSDictionary *)updateGroupName:(NSString *)groupName groupID:(NSInteger)groupID
{
    NSError *error = nil;
    CPTableGroupRecord *group = (CPTableGroupRecord *)[self.groupTable findWithPrimaryKey:@(groupID) error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    group.name = groupName;
    [self.groupTable updateRecord:group error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return [group dictionaryRepresentationWithTable:self.groupTable];
}

- (void)deleteGroup:(NSInteger)groupID
{
    NSError *error = nil;
    [self.groupTable deleteWithPrimaryKey:@(groupID) error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

#pragma mark - item
- (NSArray *)itemListWithGroupID:(NSInteger)groupID
{
    NSError *error = nil;
    NSArray <NSObject <CTPersistanceRecordProtocol> *> *itemRecordList = [self.itemTable findAllWithKeyName:@"groupid" value:@(groupID) error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    NSMutableArray *itemList = [[NSMutableArray alloc] init];
    for (NSObject <CTPersistanceRecordProtocol> *item in itemRecordList) {
        [itemList addObject:[item dictionaryRepresentationWithTable:self.itemTable]];
    }
    return itemList;
}

- (NSDictionary *)addItemWithTitle:(NSString *)title content:(NSString *)content groupID:(NSInteger)groupID
{
    CPTableItemRecord *itemRecord = [[CPTableItemRecord alloc] init];
    itemRecord.title = title;
    itemRecord.content = content;
    itemRecord.groupid = @(groupID);
    
    NSError *error = nil;
    [self.itemTable insertRecord:itemRecord error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return [itemRecord dictionaryRepresentationWithTable:self.itemTable];
}

- (NSDictionary *)updateItemTitle:(NSString *)title itemID:(NSInteger)itemID
{
    NSError *error = nil;
    CPTableItemRecord *itemRecord = (CPTableItemRecord *)[self.itemTable findWithPrimaryKey:@(itemID) error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    itemRecord.title = title;
    [self.itemTable updateRecord:itemRecord error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return [itemRecord dictionaryRepresentationWithTable:self.itemTable];
}

- (NSDictionary *)updateItemContent:(NSString *)content itemID:(NSInteger)itemID
{
    NSError *error = nil;
    CPTableItemRecord *itemRecord = (CPTableItemRecord *)[self.itemTable findWithPrimaryKey:@(itemID) error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    itemRecord.content = content;
    [self.itemTable updateRecord:itemRecord error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return [itemRecord dictionaryRepresentationWithTable:self.itemTable];
}

- (NSDictionary *)updateItemTitle:(NSString *)title content:(NSString *)content itemID:(NSInteger)itemID
{
    NSError *error = nil;
    CPTableItemRecord *itemRecord = (CPTableItemRecord *)[self.itemTable findWithPrimaryKey:@(itemID) error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    itemRecord.title = title;
    itemRecord.content = content;
    
    [self.itemTable updateRecord:itemRecord error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return [itemRecord dictionaryRepresentationWithTable:self.itemTable];
}

- (void)deleteItemWithItemID:(NSInteger)itemID
{
    NSError *error = nil;
    [self.itemTable deleteWithPrimaryKey:@(itemID) error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
}

#pragma mark - getters and setters
- (CPTableGroup *)groupTable
{
    if (_groupTable == nil) {
        _groupTable = [[CPTableGroup alloc] init];
    }
    return _groupTable;
}

- (CPTableItem *)itemTable
{
    if (_itemTable == nil) {
        _itemTable = [[CPTableItem alloc] init];
    }
    return _itemTable;
}

@end
