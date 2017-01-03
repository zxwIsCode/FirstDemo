# FirstDemo
这是一个新项目开始的基本框架搭建
下面说一下原则：
1.初始化项目
    本项目主要是创建项目，添加PCH文件，导入常用第三方库，导入工具类，定制TabBar，定制NavBar，网络层基本搭建与使用
2.整个项目的目录结构
    项目主目录下分为：Helper，Utils，General,Classes,Vendor,Resource,SupportingFiles 等库
    下面将说下这些的区别：
    1.其中Helper和Utils都相当于工具类库，只是Helper 更倾向于Tool的解决（如时间戳转化，判断是否是电话号码等）
    2.而Utils 更倾向View的定制，如Button，lable工厂方法的实现等
    3.General 指的是总体上的，如AppDelegate,.pch文件,常用的宏定义.h文件件以及项目中用到的如Url缩写的.h和.m文件
    4.Classes 指的是项目中用到的的功能分类的所有的MVC架构项目
    5.Vendor 指的是第三方库的导入（后期用cocoapods就不怎么用了）
    6.Resource 指的是图片等资源库的导入
    7.SupportingFiles  指的是一些杂项，几乎用处不是太大的库
3.自己定制Nav的使用
首先写的类继承 我的 CMBaseViewController 然后默认使用我所设计的只有右侧Nav没有的状态
分为以下层次实现：
第一层次：如果只想改变item的显示位置与个数：就重写我的-(CMNavType)getNavType;方法，然后返回设置对应的如下

CMNavTypeAll =0,      //左中右item都有
CMNavTypeNoRightItem ,//右item没有
CMNavTypeOnlyTitle ,  //只有中间item有
CMNavTypeNone,        //没有navbar

设置Nav显示的对应状态；
第二层次：如果想进一步定制nav上某个item的名称，则重写我的如下方法：
-(NSString *)customNavigationRightItemTitle;// 右侧item文字变化

-(NSString *)customNavigationTitleViewTitleStr; // 左侧item文字变化
返回您对应的文字就可以了；
其中中间title，默认用的就是您所在类中的self.title设置的文字，所以一般不需要重写
第三层次：如果整个item您都不满意，那么就重写以下的方法：
//定制导航栏上的titleView
- (void)customNavigationTitleView;

//定制导航栏左边的按钮
- (void)customNavigationLeftItem;

//定制导航栏右边的按钮
- (void)customNavigationRighItem;
自己定制自己的item，多爽！

注意：以下2个方法为nav的左右Item的点击后的实现，默认，如果有右侧item，必须重写下面的第二个方法，默认，点击左侧的item，是pop当前的控制器，如果您想做自己的业务逻辑处理，请重写下面的第一个方法。
- (void)navigationLeftButtonClick:(id)sender;
- (void)navigationRightButtonClick:(id)sender;

4.网络架构的优缺点分析
具体网络架构其实不是太难，一般都可以看得懂，简单来说其实就是，发送网络请求的时候，包装一个request对象要遵循我的一个request协议，之后返回数据，我再用我的包装对象调用其遵循的协议方法，在协议方法里面再通过response对象遵循response协议，一方面调用response的协议方法去包装我的response对象，另一方面通过调用在发送参数中的block对象达到数据（我要的数据或者错误）传给我的request对象的callBack的block，在里面通过response对象的一些属性，简单判断就实现了，如下是我的网络请求示例：

// 参数初始化
CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
NSDictionary *paramsDic =@{@"qq":@"1824496534"};

// 参数包装
model.appendUrl =kTestQQGetNickNameURL;
model.paramDic =[paramsDic mutableCopy];
// 返回数据处理
model.callback =^(CMHttpResponseModel *result, NSError *error) {

if (result.isSucc) {// 成功,做自己的逻辑
DDLog(@"%@",result.data);
mAlertView(@"提示", @"网络请求成功");

}else {// 失败,弹框提示
mAlertView(@"提示", result.alertMsg);
DDLog(@"%@",result.error);
}

};
// 发送网络请求
[[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];

如此  so easy！

与传统的定义成功block和失败block或者代理去告诉我成功或错误的逻辑处理，它有明显的以下优点：
//1.不 care 错误的内容处理，初次解析什么的代码全都放在response内部去实现
//2.不 care每个请求都要么再写一个Post方法。要么无法控制请求
//3.未来如果需要对请求的先后顺序以及发出去请求的任务进行 cancle的时候，也可以实现

不过它唯一的不算缺点是：就需要您和您的后台定义好整个接口的架构，因为整个项目返回参数的意思的架构每个都必须一致。。。。
本来架构的时候，还担心有另一个缺点：即那么多callback的实现，会不会调用一下其他地方也都会响应，就会出问题了，幸好，每个参数对象，如上的：
CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
只有在自己的函数内部可以有用，出了函数就自己销毁了，真好！
不过还是要说下它的缺点，即您的request参数不能成为类的成员属性，更不能在一个方法内发送2个request，切记！

5.关于如何开启新项目来对接我的空项目的问题：

（1）删除并移动自己的新项目
删除新项目的AppDelegate.h 和.m 文件，以及info.plist 等文件
移动其他 的如：Main.storyboard ,ViewController.h 和.m 以及info.plist等到Supporting Files 的文件夹中

（2）添加空项目中的库到新项目中
添加的类型如下：Helper（侧重tool），Utils（侧重View），General，Classes，Vendor，Resource（可导可不导）

（3）修改PCH文件名字以及路径（注意其路径中间要加上一个General）如下:
$(SRCROOT)/您的项目名字/General/FarmAnimalPrefix.pch（您的pch文件名字）

（4）按照空项目中的引用类库导入对应的类库

    1.第三方库中有fmdb的：导入libsqlite3.tbd 库
    2.有分享的，按照ShareSDK的要求导入对应的库

（5）编译通过就愉快的写代码吧！
其他就没发现有什么问题，如发现问题，欢迎联系QQ1824496534：备注：新项目。谢谢！


