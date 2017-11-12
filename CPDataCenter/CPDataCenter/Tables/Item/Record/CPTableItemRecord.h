//
//  CPTableItemRecord.h
//  CPDataCenter
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <CTPersistance/CTPersistance.h>

@interface CPTableItemRecord : CTPersistanceRecord

@property (nonatomic, strong) NSNumber *primaryKey;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *groupid;

@end
