
%hook GDTSplashDefaultSkipView
-(void)didMoveToWindow{
    [self performSelector:NSSelectorFromString(@"handleSingleTapGesture:") withObject:@""];
    %orig;
}
+(void)initialize{
    NSLog(@"GDTSplashDefaultSkipView --initialize");
}
%new
- (void)addNewMethod
{
    //%new 添加新方法，需要添加到头文件才能调用
    NSLog(@"动态添加一个方法到SpringBoard");
}
%end

%hook AFHTTPSessionManager
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
       URLString:(NSString *)URLString
      parameters:(id)parameters
  uploadProgress:(void (^)(NSProgress *uploadProgress)) uploadProgress
downloadProgress:(void (^)(NSProgress *downloadProgress)) downloadProgress
         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    if (parameters != nil) {
        NSString * bodyStr;
        @try {
            if ([parameters isKindOfClass:[NSDictionary class]] || [parameters isKindOfClass:[NSArray class]]) {
                NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
                bodyStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            }else if ([parameters isKindOfClass:[NSData class]]){
                bodyStr = [[NSString alloc]initWithData:(NSData *)parameters encoding:NSUTF8StringEncoding];
            }else if([parameters isKindOfClass:[NSString class]]){
                bodyStr = parameters;
            }
            NSURL * _baseURL = [self valueForKey:@"baseURL"];
            NSString * url1 = URLString;
            if (_baseURL != nil) {
                NSString * path1 = @"/";
                if ([_baseURL.absoluteString hasSuffix:@"/"] || [url1 hasPrefix:@"/"]) {
                    path1 = @"";
                }
                url1 = [NSString stringWithFormat:@"%@%@%@",_baseURL.absoluteURL,path1,url1];
            }
            NSDictionary * HTTPRequestHeaders = [self valueForKeyPath:@"requestSerializer.HTTPRequestHeaders"];
            NSString * headersStr = @"";
            if (HTTPRequestHeaders != nil) {
                NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
                headersStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            }
            NSLog(@"adblock %@   %@  body-> %@  headers->%@",method ,url1,bodyStr, headersStr);


        } @catch (NSException *exception) {
            NSLog(@"adblock %@",exception);
        } @finally {

        }
    }
    return %orig;
}
%end

%ctor
{
  NSString * processName = [[NSProcessInfo processInfo] processName];
    NSLog(@"打印当前的进程%@",processName);
}
