//
//  PayUtils.h
//  AliSDKDemo
//
//  Created by hcl on 16/1/20.
//  Copyright © 2016年 Alipay.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
@protocol stringDelegate<NSObject>
-(void)getResult:(NSDictionary *)sender;
@end

@interface PayUitls : NSObject<UIWebViewDelegate,WXApiDelegate>
/*
 *packageId  包编号
 *fee        金额(分)
 *tradeName  商品名称
 *goodsDetails 商品详情
 *channelOrderId 渠道订单ID
 *result     支付结果回调
 *schemename 支付完成跳转标示
 *type 1:支付宝支付  2:微信支付
 */
+(PayUitls*)getIntents;
-(void)PayEnterForeground;
-(void)paytoAli:(NSURL *)url;
-(void)gotoPayByPackageId:(int)packageId andFee:(int)fee andTradeName :(NSString*)tradeName andGoodsDetails:(NSString*)goodsDetails andScheme:(NSString*)schemeName  andchannelOrderId:(NSString*)channelOrderId  andType:(int)type;
@property (assign,nonatomic)id<stringDelegate> delegate;

@end
