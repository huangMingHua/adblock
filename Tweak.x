
%hook GDTSplashDefaultSkipView
-(void)didMoveToWindow{
    [self performSelector:NSSelectorFromString(@"handleSingleTapGesture:") withObject:@""];
    %orig;
}

%new
- (void)addNewMethod
{
    //%new 添加新方法，需要添加到头文件才能调用
    NSLog(@"动态添加一个方法到SpringBoard");
}
%end
