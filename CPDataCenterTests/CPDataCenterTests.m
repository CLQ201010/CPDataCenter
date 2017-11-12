//
//  CPDataCenterTests.m
//  CPDataCenterTests
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CPDataCenter.h"
#import "CPTableItem.h"
#import "CPTableGroup.h"

@interface CPDataCenterTests : XCTestCase

@property (nonatomic, strong) CPDataCenter *dataCenter;

@end

@implementation CPDataCenterTests

- (void)setUp {
    [super setUp];
    self.dataCenter = [[CPDataCenter alloc] initWithSecretKey:@"test"];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGroupList {
    CPTableGroup *groupTable = [[CPTableGroup alloc] init];
    [groupTable truncate];
    
    [self.dataCenter addGroup:@"test1"];
    [self.dataCenter addGroup:@"test2"];
    
    NSArray <NSDictionary *> *groupList = [self.dataCenter groupList];
    XCTAssertEqual(groupList.count, 2);
}

- (void)testDeleteGroup {
    CPTableGroup *groupTable = [[CPTableGroup alloc] init];
    [groupTable truncate];
    
    [self.dataCenter addGroup:@"test1"];
    NSDictionary *group = [self.dataCenter addGroup:@"test2"];
    [self.dataCenter deleteGroup:[group[@"primaryKey"] integerValue]];
    
    NSArray <NSDictionary *> *groupList = [self.dataCenter groupList];
    XCTAssertEqual(groupList.count, 1);
}

- (void)testUpdateGroup {
    CPTableGroup *groupTable = [[CPTableGroup alloc] init];
    [groupTable truncate];
    
    NSDictionary *group = [self.dataCenter addGroup:@"test1"];
    [self.dataCenter updateGroupName:@"casa" groupID:[group[@"primaryKey"] integerValue]];
    group = [[self.dataCenter groupList] firstObject];
    XCTAssertEqual([group[@"name"] isEqualToString:@"casa"], YES);
}

- (void)testInsertItem {
    CPTableGroup *groupTable = [[CPTableGroup alloc] init];
    [groupTable truncate];
    CPTableItem *itemTable = [[CPTableItem alloc] init];
    [itemTable truncate];
    
    NSDictionary *group = [self.dataCenter addGroup:@"test1"];
    NSInteger groupid = [group[@"primaryKey"] integerValue];
    
    [self.dataCenter addItemWithTitle:@"title" content:@"content" groupID:groupid];
    [self.dataCenter addItemWithTitle:@"title" content:@"content" groupID:groupid];
    
    NSArray *itemList = [self.dataCenter itemListWithGroupID:groupid];
    XCTAssertEqual(itemList.count, 2);
}

- (void)testDeleteItem {
    CPTableGroup *groupTable = [[CPTableGroup alloc] init];
    [groupTable truncate];
    CPTableItem *itemTable = [[CPTableItem alloc] init];
    [itemTable truncate];
    
    NSDictionary *group = [self.dataCenter addGroup:@"test1"];
    NSInteger groupid = [group[@"primaryKey"] integerValue];
    
    [self.dataCenter addItemWithTitle:@"title" content:@"content" groupID:groupid];
    NSDictionary *item = [self.dataCenter addItemWithTitle:@"title" content:@"content" groupID:groupid];
    NSInteger itemID = [item[@"primaryKey"] integerValue];
    
    [self.dataCenter deleteItemWithItemID:itemID];
    
    NSArray *itemList = [self.dataCenter itemListWithGroupID:groupid];
    XCTAssertEqual(itemList.count, 1);
}

- (void)testUpdateItem {
    CPTableGroup *groupTable = [[CPTableGroup alloc] init];
    [groupTable truncate];
    CPTableItem *itemTable = [[CPTableItem alloc] init];
    [itemTable truncate];
    
    NSDictionary *group = [self.dataCenter addGroup:@"test1"];
    NSInteger groupid = [group[@"primaryKey"] integerValue];
    
    NSDictionary *item = [self.dataCenter addItemWithTitle:@"title" content:@"content" groupID:groupid];
    NSInteger itemID = [item[@"primaryKey"] integerValue];
    
    [self.dataCenter updateItemTitle:@"itemTitle" itemID:itemID];
    item = [[self.dataCenter itemListWithGroupID:groupid] firstObject];
    XCTAssertEqual([item[@"title"] isEqualToString:@"itemTitle"], YES);
    
    [self.dataCenter updateItemTitle:@"casa" content:@"itemContent" itemID:itemID];
    item = [[self.dataCenter itemListWithGroupID:groupid] firstObject];
    XCTAssertEqual([item[@"title"] isEqualToString:@"casa"], YES);
    XCTAssertEqual([item[@"content"] isEqualToString:@"itemContent"], YES);
    
    [self.dataCenter updateItemContent:@"updateItemContent" itemID:itemID];
    item = [[self.dataCenter itemListWithGroupID:groupid] firstObject];
    XCTAssertEqual([item[@"content"] isEqualToString:@"updateItemContent"], YES);
}

@end
