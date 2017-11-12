//
//  CPDataCenter.h
//  CPDataCenter
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDataCenter : NSObject

- (instancetype)initWithSecretKey:(NSString *)secretKey;

- (NSArray <NSDictionary *> *)groupList;
- (NSDictionary *)addGroup:(NSString *)groupName;
- (NSDictionary *)updateGroupName:(NSString *)groupName groupID:(NSInteger)groupID;
- (void)deleteGroup:(NSInteger)groupID;

- (NSArray *)itemListWithGroupID:(NSInteger)groupID;
- (NSDictionary *)addItemWithTitle:(NSString *)title content:(NSString *)content groupID:(NSInteger)groupID;
- (NSDictionary *)updateItemTitle:(NSString *)title itemID:(NSInteger)itemID;
- (NSDictionary *)updateItemContent:(NSString *)content itemID:(NSInteger)itemID;
- (NSDictionary *)updateItemTitle:(NSString *)title content:(NSString *)content itemID:(NSInteger)itemID;
- (void)deleteItemWithItemID:(NSInteger)itemID;

@end
