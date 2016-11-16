//
//  CMHttpResponseModel.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMHttpResponseModel.h"

@implementation CMHttpResponseModel

@synthesize error = _error;
@synthesize code = _code;
@synthesize data = _data;

-(id)initWithData:(id)responseData err:(NSError *)err {
    if (self =[super init]) {
        DDLog(@"返回数据为：responseData = %@ err =%@",responseData,err);
        if (err) {// 有错误的处理
            _isSucc =NO;
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                NSNumber *code = [responseData objectForKey:@"type"];
                NSString *errorMsg =[responseData objectForKey:@"message"];
                _error = [NSError errorWithDomain:errorMsg
                                             code:code.integerValue
                                         userInfo:nil];
            }
            
        }else {
            if ([responseData isKindOfClass:[NSDictionary class]]) {// 正常返回数据处理
                NSNumber *code = [responseData objectForKey:@"type"];
                if ([code longValue] ==1) {
                    id data = [responseData objectForKey:@"info"];
                    _isSucc =YES;
                    _data =data;

                }
                
                NSString *alertMsg =[responseData objectForKey:@"message"];
                _alertMsg =alertMsg;

            }else {// 服务器返回数据问题
                
                _isSucc = NO;
                _error = [NSError errorWithDomain:@"服务器返回数据结构异常"
                                             code:-100
                                         userInfo:nil];
                
            }
            
        }
    }
    return self;
}
@end
