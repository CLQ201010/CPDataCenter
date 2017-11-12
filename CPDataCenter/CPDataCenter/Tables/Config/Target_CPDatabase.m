//
//  Target_CPDatabase.m
//  CPDataCenter
//
//  Created by casa on 2017/11/12.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "Target_CPDatabase.h"

@implementation Target_CPDatabase

#pragma mark - CTPersistanceConfigurationTarget
- (NSString *)Action_secretKey:(NSDictionary *)params
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"CPDatabaseSecretKey"];
}

@end
