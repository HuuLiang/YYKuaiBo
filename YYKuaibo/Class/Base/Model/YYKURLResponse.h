//
//  YYKURLResponse.h
//  kuaibov
//
//  Created by Sean Yue on 15/9/3.
//  Copyright (c) 2015年 kuaibov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYKURLResponse : NSObject

@property (nonatomic) NSNumber *success;
@property (nonatomic) NSString *resultCode;


- (void)parseResponseWithDictionary:(NSDictionary *)dic;

@end
