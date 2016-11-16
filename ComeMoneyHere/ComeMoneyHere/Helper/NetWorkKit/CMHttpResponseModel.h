//
//  CMHttpResponseModel.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMResponseDelegate.h"

@interface CMHttpResponseModel : NSObject<CMResponseDelegate>

@property (nonatomic, assign, readonly) BOOL isSucc;   //结果
@property (nonatomic, assign, readonly) NSInteger code;   //结果
@property (nonatomic, copy, readonly) NSString *alertMsg;   //提示信息
@property (nonatomic, assign, readonly) id data;   //数据
@property (nonatomic, strong, readonly) NSError *error;  //业务错误

@end
