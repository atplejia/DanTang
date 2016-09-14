##前言
*很久都没有写文章了，很早之前就一直说一说Swift项目的讲解，但是自己的知识范围有限，很多东西还是不知道的，经过大半年晚上在公司学习的时间,苹果Swift语言的练习，迎来了今天的文章，看看视频教程，练习基础，以及多看开源的项目，反复的写代码，自己都写吐了，看多了都觉得很恶心，这次的项目是自己高仿开源的项目，差不多对着写了一遍外加自己写的的小功能，哈哈哈😄，重点是带领大家如何学习,如何怎么上手Swift，我这里的回答刚刚已经说哈。好了，我们先看看效果图*

![Snip20160805_8.png](http://upload-images.jianshu.io/upload_images/1754828-b0f0c4a48e091c41.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 这是整个项目结构，讲项目之前我们先不着急。这里先说明一下`单糖.xcworkspace`

![Snip20160805_9.png](http://upload-images.jianshu.io/upload_images/1754828-7ce6bb2b3dd0755e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 很多小伙们都不知道这是什么东西，很陌生，因为Xcode创建的都是`xcodeproj`为什么会多了`xcworkspace`，这是什么东西，用来干什么的，是怎么生成的？很多的奇怪的问题，其实这是本人在Xcode安装的插件`cocoapods`

![Snip20160808_1.png](http://upload-images.jianshu.io/upload_images/1754828-cb9965811d83356e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- `Xcode`没有怎么办？怎么弄的呢？这是要去github下载的

![Snip20160808_2.png](http://upload-images.jianshu.io/upload_images/1754828-08a66d55b6d0c73c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

点击github官网，搜索  `cocoapods`,点击旁边的语言`object-c`第一个就是我们所要找的插件，可以点击进入介绍

![Snip20160808_4.png](http://upload-images.jianshu.io/upload_images/1754828-819561c922997d69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![Snip20160808_5.png](http://upload-images.jianshu.io/upload_images/1754828-f3822f27568af1d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 下载好了之后，我们就可以开始使用了，点击create/Edit podfile，会看到要你填写一些东西，这里我用项目举例子，想要什么框架直接`pod "xxxx"`，填写完毕之后直接`install pods`就是这么简单

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, "8.0"
use_frameworks!

target :"单糖" do
pod "SnapKit"
pod "Kingfisher"
pod "SVProgressHUD"
pod "FDFullscreenPopGesture", "~> 1.1"
pod "Alamofire"
pod "SwiftyJSON"

end
```


![Snip20160808_6.png](http://upload-images.jianshu.io/upload_images/1754828-2f46fe68086e9aa1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


- 具体怎么安装和使用，我这里不介绍了，小伙伴们可以自己去动手试一试，遇到问题可以在评论留言，这里本人也是第一次搞这个插件也很痛苦，花了一下午的时间，不是很难，而是很烦，中途出现很多配置问题以及版本兼容的问题，看人品吧，不是每天一次环境搭建都能成功

###项目说明

- 这里开始讲解一下项目了，上述内容是讲一下小知识的介绍和认识使用,先看看项目的启动

![启动.gif](http://upload-images.jianshu.io/upload_images/1754828-29af7b631e5f20c6.gif?imageMogr2/auto-orient/strip)

- `Swift`项目也是一样，都是在`AppDelegate.swift`这个类启动程序

```
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        //检查进入沙盒是否引导页的判断
        if !NSUserDefaults.standardUserDefaults().boolForKey(QJLFirstLaunch) {
            window?.rootViewController = QJLNewfeatureViewController()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: QJLFirstLaunch)
        }else{
            window?.rootViewController = QJLTabBarController()
        }
        
   
        setUM()
        return true
        
    }
    
    //重写openURL
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject])
        -> Bool {
            return TencentOAuth.HandleOpenURL(url)
    }
    
    //重写handleOpenURL
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return TencentOAuth.HandleOpenURL(url)
    }

```
- 和oc相识，只是写法看着有点别扭，启动的时候判断是否是沙盒，不知道怎么实现的可以去百度怎么完成的，还有就是如何定义一个方法,swift就是用函数定义一个方法我们看到启动`setUM`友盟这是，然后实现这个方法就是`func setUM() {}`,oc呢？`[self XXX] ` 实现就是`-(void)xxxx`
写法上很多的别扭，我们在看看结构`TabbarController`这个控制器

```
class QJLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        // 添加子控制器
        addChildViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
     # 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController("QJLDanTangViewController", title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController("QJLProductViewController", title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController("QJLCategoryViewController", title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController("QJLMeViewController", title: "我", imageName: "TabBar_me_boy_23x23_")
    }
    
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childControllerName: String, title: String, imageName: String) {
        // 动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        // 设置对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        // 给每个控制器包装一个导航控制器
        let nav = QJLNavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
    }
}

```

- 自定义的`Tabbar`和oc的写法也一致，只是看着简单了很多，分别加上四大控制器，还有那句包装一个导航控制器也是一样

![Snip20160808_7.png](http://upload-images.jianshu.io/upload_images/1754828-a7d6cddfa15ef807.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
import UIKit
import SVProgressHUD

class QJLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏的标题栏
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = QJLlobalRedColor()
        navBar.tintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),NSFontAttributeName:UIFont .systemFontOfSize(20)]

    }

    /**
     # 统一所有控制器导航栏左上角的返回按钮
     # 让所有push进来的控制器，它的导航栏左上角的内容都一样
     # 能拦截所有的push操作
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if viewControllers.count > 0 {
            // push 后隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: true)
    }
    /// 返回按钮
    func navigationBackClick() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        if UIApplication.sharedApplication().networkActivityIndicatorVisible {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        popViewControllerAnimated(true)
    }

}
```

- siwft导入第三方文件是`import XXX`，说明一下，siwft无需导入应用类，它自己会找到在哪里，一般都是导入一下第三方的库，这就要用到桥接了`单糖-Bridging-Header`,我这里重点说明，这个很重要，怎么桥接oc类，下图就是桥接配置，首先要设置一下头文件的路径，`项目名字/文件名`然后在头文件写上要引用的类



![Snip20160808_8.png](http://upload-images.jianshu.io/upload_images/1754828-130ae5fef276082c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Snip20160808_9.png](http://upload-images.jianshu.io/upload_images/1754828-e1728f135982e581.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 在头文件写上引入的类，这样就桥接oc了,这里看到了一些SKD的应用腾讯的还有友盟的,以及李明杰老师的刷新框架
- 有关于宏，Swift没有宏定义，还有和宏定义相识的
- 直接创建一个siwft类，后面想写什么自己去填写

```

import UIKit

enum QJLTopicType: Int {
    /// 精选
    case Selection = 4
    /// 美食
    case Food = 14
    /// 家居
    case Household = 16
    /// 数码
    case Digital = 17
    /// 美物
    case GoodThing = 13
    /// 杂货
    case Grocery = 22
}

enum QJLShareButtonType: Int {
    /// 微信朋友圈
    case WeChatTimeline = 0
    /// 微信好友
    case WeChatSession = 1
    /// 微博
    case Weibo = 2
    /// QQ 空间
    case QZone = 3
    /// QQ 好友
    case QQFriends = 4
    /// 复制链接
    case CopyLink = 5
}

enum QJLOtherLoginButtonType: Int {
    /// 微博
    case weiboLogin = 100
    /// 微信
    case weChatLogin = 101
    /// QQ
    case QQLogin = 102
}

/// 服务器地址
let BASE_URL = "http://api.dantangapp.com/"

/// 第一次启动
let QJLFirstLaunch = "firstLaunch"
/// 是否登录
let isLogin = "isLogin"

/// code 码 200 操作成功
let RETURN_OK = 200
/// 间距
let kMargin: CGFloat = 10.0
/// 圆角
let kCornerRadius: CGFloat = 5.0
/// 线宽
let klineWidth: CGFloat = 1.0
/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
/// 新特性界面图片数量
let kNewFeatureCount = 4
/// 顶部标题的高度
let kTitlesViewH: CGFloat = 35
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64
/// 动画时长
let kAnimationDuration = 0.25
/// 屏幕的宽
let SCREENW = UIScreen.mainScreen().bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.mainScreen().bounds.size.height
/// 分类界面 顶部 item 的高
let kitemH: CGFloat = 75
/// 分类界面 顶部 item 的宽
let kitemW: CGFloat = 150
// 分享按钮背景高度
let kTopViewH: CGFloat = 230
public let CouponViewControllerMargin: CGFloat = 20


/// RGBA的颜色设置
func QJLColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func QJLGlobalColor() -> UIColor {
    return QJLColor(240, g: 240, b: 240, a: 1)
}

/// 红色
func QJLlobalRedColor() -> UIColor {
    return QJLColor(245, g: 80, b: 83, a: 1.0)
}

public let GitHubURLString: String = "http://git.oschina.net/www.skyheng.com"
public let SinaWeiBoURLString: String = "http://weibo.com/u/5500516766?sudaref=www.jianshu.com&retcode=6102&is_all=1"
public let BlogURLString: String = "http://www.jianshu.com/users/ef13bae228f6/latest_articles"
/// 购买商品数量发生改变
public let LFBShopCarBuyProductNumberDidChangeNotification = "LFBShopCarBuyProductNumberDidChangeNotification"
public let HomeCollectionTextFont = UIFont.systemFontOfSize(14)

/// iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREENH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false

```

###首页

- 我们先看看首页的具体内容的实现
- 说明一下在Swift中用到布局框架是`SnapKit`而oc中是用Marsony布局，Swift是用`Alamofire`框架，而oc中是用`AFN`

```
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏
        setupNav()
        weak var weakSelf = self
        // 获取首页顶部选择数据
        QJLNetworkTool.shareNetworkTool.loadHomeTopData { (ym_channels) in
            for channel in ym_channels {
                let vc = QJLTopicViewController()
                vc.title = channel.name!
                vc.type = channel.id!
                weakSelf!.addChildViewController(vc)
            }
            //设置顶部标签栏
            weakSelf!.setupTitlesView()
            // 底部的scrollview
            weakSelf!.setupContentView()
        }
    }

```
- 在`viewDidLoad`这个方法中实现UI界面，可以看到`setupNav()`这个函数，还有分别设置顶部选择数据的标签和 底部滚动的`scrollview`

```
  /// 顶部标签栏
    func setupTitlesView() {
        // 顶部背景
        let bgView = UIView()
        bgView.frame = CGRectMake(0, kTitlesViewY, SCREENW, kTitlesViewH)
        view.addSubview(bgView)
        // 标签
        let titlesView = UIView()
        titlesView.backgroundColor = QJLGlobalColor()
        titlesView.frame = CGRectMake(0, 0, SCREENW - kTitlesViewH, kTitlesViewH)
        bgView.addSubview(titlesView)
        self.titlesView = titlesView
        //底部红色指示器
        let indicatorView = UIView()
        indicatorView.backgroundColor = QJLlobalRedColor()
        indicatorView.height = kIndicatorViewH
        indicatorView.y = kTitlesViewH - kIndicatorViewH
        indicatorView.tag = -1
        self.indicatorView = indicatorView
        
        // 右边搜索选择按钮
        let arrowButton = UIButton()
        arrowButton.frame = CGRectMake(SCREENW - kTitlesViewH, 0, kTitlesViewH, kTitlesViewH)
        arrowButton.setImage(UIImage(named: "arrow_index_down_8x4_"), forState: .Normal)
        arrowButton.addTarget(self, action: #selector(arrowButtonClick(_:)), forControlEvents: .TouchUpInside)
        arrowButton.backgroundColor = QJLGlobalColor()
        bgView.addSubview(arrowButton)
        
        //内部子标签
        let count = childViewControllers.count
        let width = titlesView.width / CGFloat(count)
        let height = titlesView.height
        
        for index in 0..<count {
            let button = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index) * width
            button.tag = index
            let vc = childViewControllers[index]
            button.titleLabel!.font = UIFont.systemFontOfSize(14)
            button.setTitle(vc.title!, forState: .Normal)
            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            button.setTitleColor(QJLlobalRedColor(), forState: .Disabled)
            button.addTarget(self, action: #selector(titlesClick(_:)), forControlEvents: .TouchUpInside)
            titlesView.addSubview(button)
            //默认点击了第一个按钮
            if index == 0 {
                button.enabled = false
                selectedButton = button
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
                indicatorView.width = button.titleLabel!.width
                indicatorView.centerX = button.centerX
            }
        }
        //底部红色指示器
        titlesView.addSubview(indicatorView)
    }
    
    /// 箭头按钮点击
    func arrowButtonClick(button: UIButton) {
        UIView.animateWithDuration(kAnimationDuration) {
            button.imageView?.transform = CGAffineTransformRotate(button.imageView!.transform, CGFloat(M_PI))
        }
    }
    
    /// 标签上的按钮点击
    func titlesClick(button: UIButton) {
        // 修改按钮状态
        selectedButton!.enabled = true
        button.enabled = false
        selectedButton = button
        // 让标签执行动画
        UIView.animateWithDuration(kAnimationDuration) {
            self.indicatorView!.width = self.selectedButton!.titleLabel!.width
            self.indicatorView!.centerX = self.selectedButton!.centerX
        }
        //滚动,切换子控制器
        var offset = contentView!.contentOffset
        offset.x = CGFloat(button.tag) * contentView!.width
        contentView!.setContentOffset(offset, animated: true)
    }
    
    /// 底部的scrollview
    func setupContentView() {
        //不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.delegate = self
        contentView.contentSize = CGSizeMake(contentView.width * CGFloat(childViewControllers.count), 0)
        contentView.pagingEnabled = true
        view.insertSubview(contentView, atIndex: 0)
        self.contentView = contentView
        //添加第一个控制器的view
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    /// 设置导航栏
    func setupNav() {
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .Plain, target: self, action: #selector(dantangRightBBClick))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_black_scancode"), style: .Plain, target: self, action: #selector(leftItemClick))
       
    }


```

- 导航栏左右两边的二维码扫一扫是用`QRCode`,实现的

```
import UIKit
import AVFoundation


class QRCodeViewController: QJLBaseViewController,AVCaptureMetadataOutputObjectsDelegate {
    private var titleLabel = UILabel()
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var animationLineView = UIImageView()
    private var timer: NSTimer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        buildInputAVCaptureDevice()
        
        buildFrameImageView()
        
        buildTitleLabel()
        
        buildAnimationLineView()

        // Do any additional setup after loading the view.
    }
    
    

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    private func buildTitleLabel() {
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.frame = CGRectMake(0, 340, ScreenWidth, 30)
        titleLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(titleLabel)
    }
    
    private func buildInputAVCaptureDevice() {
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        titleLabel.text = "请对准二维码方块内扫面"
        let input = try? AVCaptureDeviceInput(device: captureDevice)
        if input == nil {
            titleLabel.text = "请换真机试试"
            
            return
        }
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession = AVCaptureSession()
        captureSession?.addInput(input!)
        captureSession?.addOutput(captureMetadataOutput)
        let dispatchQueue = dispatch_queue_create("myQueue", nil)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.frame
        view.layer.addSublayer(videoPreviewLayer!)
        captureMetadataOutput.rectOfInterest = CGRectMake(0, 0, 1, 1)
        
        captureSession?.startRunning()
    }
    
    private func buildFrameImageView() {
        
        let lineT = [CGRectMake(0, 0, ScreenWidth, 100),
                     CGRectMake(0, 100, ScreenWidth * 0.2, ScreenWidth * 0.6),
                     CGRectMake(0, 100 + ScreenWidth * 0.6, ScreenWidth, ScreenHeight - 100 - ScreenWidth * 0.6),
                     CGRectMake(ScreenWidth * 0.8, 100, ScreenWidth * 0.2, ScreenWidth * 0.6)]
        for lineTFrame in lineT {
            buildTransparentView(lineTFrame)
        }
        
        let lineR = [CGRectMake(ScreenWidth * 0.2, 100, ScreenWidth * 0.6, 2),
                     CGRectMake(ScreenWidth * 0.2, 100, 2, ScreenWidth * 0.6),
                     CGRectMake(ScreenWidth * 0.8 - 2, 100, 2, ScreenWidth * 0.6),
                     CGRectMake(ScreenWidth * 0.2, 100 + ScreenWidth * 0.6, ScreenWidth * 0.6, 2)]
        
        for lineFrame in lineR {
            buildLineView(lineFrame)
        }
        
        let yellowHeight: CGFloat = 4
        let yellowWidth: CGFloat = 30
        let yellowX: CGFloat = ScreenWidth * 0.2
        let bottomY: CGFloat = 100 + ScreenWidth * 0.6
        let lineY = [CGRectMake(yellowX, 100, yellowWidth, yellowHeight),
                     CGRectMake(yellowX, 100, yellowHeight, yellowWidth),
                     CGRectMake(ScreenWidth * 0.8 - yellowHeight, 100, yellowHeight, yellowWidth),
                     CGRectMake(ScreenWidth * 0.8 - yellowWidth, 100, yellowWidth, yellowHeight),
                     CGRectMake(yellowX, bottomY - yellowHeight + 2, yellowWidth, yellowHeight),
                     CGRectMake(ScreenWidth * 0.8 - yellowWidth, bottomY - yellowHeight + 2, yellowWidth, yellowHeight),
                     CGRectMake(yellowX, bottomY - yellowWidth, yellowHeight, yellowWidth),
                     CGRectMake(ScreenWidth * 0.8 - yellowHeight, bottomY - yellowWidth, yellowHeight, yellowWidth)]
        
        for yellowRect in lineY {
            buildYellowLineView(yellowRect)
        }
    }
    
    private func buildLineView(frame: CGRect) {
        let view1 = UIView(frame: frame)
        view1.backgroundColor = QJLColor(253, g: 212, b: 49,a: 1)
        view.addSubview(view1)
    }
    
    private func buildYellowLineView(frame: CGRect) {
        let yellowView = UIView(frame: frame)
        yellowView.backgroundColor = QJLColor(253, g: 212, b: 49,a: 1)
        view.addSubview(yellowView)
    }
    
    private func buildTransparentView(frame: CGRect) {
        let tView = UIView(frame: frame)
        tView.backgroundColor = UIColor.blackColor()
        tView.alpha = 0.5
        view.addSubview(tView)
    }
    
    private func buildAnimationLineView() {
        animationLineView.image = UIImage(named: "yellowlight")
        view.addSubview(animationLineView)
        
        timer = NSTimer(timeInterval: 2.5, target: self, selector: "startYellowViewAnimation", userInfo: nil, repeats: true)
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer!, forMode: NSRunLoopCommonModes)
        timer!.fire()
    }
    
    func startYellowViewAnimation() {
        weak var weakSelf = self
        animationLineView.frame = CGRectMake(ScreenWidth * 0.2 + ScreenWidth * 0.1 * 0.5, 100, ScreenWidth * 0.5, 20)
        UIView.animateWithDuration(2.5) { () -> Void in
            weakSelf!.animationLineView.frame.origin.y += ScreenWidth * 0.55
        }
    }

    

}

```
- 自定义的东西比较多，还有设计其他的辅助类也很多，我这里大多数都是自己去找的。

![首页.gif](http://upload-images.jianshu.io/upload_images/1754828-55fd70f9d14b9e58.gif?imageMogr2/auto-orient/strip)



###单品

- 单品这个页面是用`setupCollectionView`实现的，和oc中的一样

```
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置collectionView
        setupCollectionView()
        
        weak var weakSelf = self
        QJLNetworkTool.shareNetworkTool.loadProductData { (products) in
            weakSelf!.products = products
            weakSelf!.collectionView!.reloadData()
        }
    }
    
    /// 设置collectionView
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        let nib = UINib(nibName: String(QJLCollectionViewCell), bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: collectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }

```

- 然后实现它的代理方法

```
extension QJLProductViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, QJLCollectionViewCellDelegate {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath) as! QJLCollectionViewCell
        cell.product = products[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = QJLProductDetailViewController()
        productDetailVC.title = "商品详情"
        productDetailVC.product = products[indexPath.item]
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - YMCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            let loginVC = QJLLoginViewController()
            loginVC.title = "登录"
            let nav = QJLNavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        } else {
            
        }
    }



```

- 这里介绍一下Swift的网络请求`NetworkTool`这个类的方法介绍,这个对于新的网络请求可能是一种难度的，作者本人也是没有认真深入，只是了解。

```
    /// 获取首页数据
    func loadHomeInfo(id: Int, finished:(homeItems: [QJLHomeItem]) -> ()) {

        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    let data = dict["data"].dictionary
                    //  字典转成模型
                    if let items = data!["items"]?.arrayObject {
                        var homeItems = [QJLHomeItem]()
                        for item in items {
                            let homeItem = QJLHomeItem(dict: item as! [String: AnyObject])
                            homeItems.append(homeItem)
                        }
                        finished(homeItems: homeItems)
                    }
                }
        }
    }

```

![单品.gif](http://upload-images.jianshu.io/upload_images/1754828-997b90a47746cbd4.gif?imageMogr2/auto-orient/strip)

###分类

- 这样页面最简单了，代码的话就这么点,`ScrollView`实现点击页面跳转就可以了，不熟练的同学可以参照代码对着写一遍就ok了，其实就是多联系

```
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .Plain, target: self, action: #selector(categoryRightBBClick))
        setupScrollView()

        // Do any additional setup after loading the view.
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        // 顶部控制器
        let headerViewController = QJLCategoryHeaderViewController()
        addChildViewController(headerViewController)
        
        let topBGView = UIView(frame: CGRectMake(0, 0, SCREENW, 135))
        scrollView.addSubview(topBGView)
        
        let headerVC = childViewControllers[0]
        topBGView.addSubview(headerVC.view)
        
        let bottomBGView = QJLCategoryBottomView(frame: CGRectMake(0, CGRectGetMaxY(topBGView.frame) + 10, SCREENW, SCREENH - 160))
        bottomBGView.backgroundColor = QJLGlobalColor()
        bottomBGView.delegate = self
        scrollView.addSubview(bottomBGView)
        scrollView.contentSize = CGSizeMake(SCREENW, CGRectGetMaxY(bottomBGView.frame))
    }
    

```



![分类.gif](http://upload-images.jianshu.io/upload_images/1754828-9e98fa5122a31557.gif?imageMogr2/auto-orient/strip)

###我

- 这个页面作者很痛苦，因为是采用其他项目嵌套进来的，其实关于网络的知识倒是没有，很多代码写的UI，新手看的就会头痛，本人也是，都感觉要吐了,个人中心采用`TableView+自定义三个视图`

```
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    /// 创建 tableView
    private func setupTableView() {
        let tableView = UITableView()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
    }

```

- 我的订单，优惠券，消息，那三个是自定义视图

```
import UIKit
import Kingfisher

enum MineHeadViewButtonType: Int {
    case Order = 0
    case Coupon = 1
    case Message = 2
}

class QJLMeChoiceView: UIView {
    
    var mineHeadViewClick:((type: MineHeadViewButtonType) -> ())?
    private let orderView = MineOrderView()
    private let couponView = MineCouponView()
    private let messageView = MineMessageView()
    private var couponNumber: UIButton?
    private let line1 = UIView()
    private let line2 = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let subViewW = SCREENW / 3.0
        orderView.frame = CGRectMake(0, 0, subViewW, height+20)
        couponView.frame = CGRectMake(subViewW, 0, subViewW, height+20)
        messageView.frame = CGRectMake(subViewW * 2, 0, subViewW, height+20)
        couponNumber?.frame = CGRectMake(subViewW * 1.56, 12, 15, 15)
        line1.frame = CGRectMake(subViewW - 0.5, height * 0.2, 1, height+10)
        line2.frame = CGRectMake(subViewW * 2 - 0.5, height * 0.2, 1, height+10)
    }
    
    func click(tap: UIGestureRecognizer) {
        if mineHeadViewClick != nil {
            
            switch tap.view!.tag {
                
            case MineHeadViewButtonType.Order.rawValue:
                mineHeadViewClick!(type: MineHeadViewButtonType.Order)
                break
                
            case MineHeadViewButtonType.Coupon.rawValue:
                mineHeadViewClick!(type: MineHeadViewButtonType.Coupon)
                break
                
            case MineHeadViewButtonType.Message.rawValue:
                mineHeadViewClick!(type: MineHeadViewButtonType.Message)
                break
                
            default: break
            }
        }
    }
     private func buildUI() {
        
        orderView.tag = 0
        addSubview(orderView)
        
        couponView.tag = 1
        addSubview(couponView)
        
        messageView.tag = 2
        addSubview(messageView)
        
        for index in 0...2 {
            let tap = UITapGestureRecognizer(target: self, action: "click:")
            let subView = viewWithTag(index)
            subView?.addGestureRecognizer(tap)
        }
        
        line1.backgroundColor = UIColor.grayColor()
        line1.alpha = 0.3
        addSubview(line1)
        
        line2.backgroundColor = UIColor.grayColor()
        line2.alpha = 0.3
        addSubview(line2)
        
        couponNumber = UIButton(type: .Custom)
        couponNumber?.setBackgroundImage(UIImage(named: "redCycle"), forState: UIControlState.Normal)
        couponNumber?.setTitleColor(UIColor.redColor(), forState: .Normal)
        couponNumber?.userInteractionEnabled = false
        couponNumber?.titleLabel?.font = UIFont.systemFontOfSize(8)
        couponNumber?.hidden = true
        addSubview(couponNumber!)
        
    }
    
    func setCouponNumer(number: Int) {
        if number > 0 && number <= 9 {
            couponNumber?.hidden = false
            couponNumber?.setTitle("\(number)", forState: .Normal)
        } else if number > 9 && number < 100 {
            couponNumber?.setTitle("\(number)", forState: .Normal)
            couponNumber?.hidden = false
        } else {
            couponNumber?.hidden = true
        }
    }

    class MineOrderView: UIView {
        
        var btn: MineUpImageDownText!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            btn = MineUpImageDownText(frame: CGRectZero, title: "我的订单", imageName: "v2_my_order_icon")
            addSubview(btn)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            btn.frame = CGRectMake(10, 10, width - 20, height - 20)
        }
    }
    
    class MineCouponView: UIView {
        
        var btn: UpImageDownTextButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            btn = MineUpImageDownText(frame: CGRectZero, title: "优惠劵", imageName: "v2_my_coupon_icon")
            addSubview(btn)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            btn.frame = CGRectMake(10, 10, width - 20, height - 20)
        }
        
    }
    
    class MineMessageView: UIView {
        var btn: UpImageDownTextButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            btn = MineUpImageDownText(frame: CGRectZero, title: "我的消息", imageName: "v2_my_message_icon")
            addSubview(btn)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            btn.frame = CGRectMake(10, 10, width - 20, height - 20)
        }
    }
    
    class MineUpImageDownText: UpImageDownTextButton {
        
        init(frame: CGRect, title: String, imageName: String) {
            super.init(frame: frame)
            setTitle(title, forState: .Normal)
            setTitleColor(QJLColor(80, g: 80, b: 80,a: 1), forState: .Normal)
            setImage(UIImage(named: imageName), forState: .Normal)
            userInteractionEnabled = false
            titleLabel?.font = UIFont.systemFontOfSize(13)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
}
```

![我.gif](http://upload-images.jianshu.io/upload_images/1754828-4cb2e34e200d31de.gif?imageMogr2/auto-orient/strip)

###超市
 - 这是采用小熊Swift项目里面参照写的，目的就是为了怎么样用，嵌套到自己的项目中，本人花了很久的时间来实现，个人中心的页面很多，设计的代码我这里一时也说不完，只能谈谈

```
lass SupermarketViewController: SelectedAdressViewController {
    
    private var supermarketData: Supermarket?
    private var categoryTableView: LFBTableView!
    private var productsVC: ProductsViewController!
    
    private var categoryTableViewIsLoadFinish = false
    private var productTableViewIsLoadFinish  = false
    
    // MARK : Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        
        showProgressHUD()
        
        bulidCategoryTableView()
        
        bulidProductsViewController()
        
        loadSupermarketData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if productsVC.productsTableView != nil {
            productsVC.productsTableView?.reloadData()
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("LFBSearchViewControllerDeinit", object: nil)
        navigationController?.navigationBar.barTintColor =  QJLlobalRedColor()

    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func addNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shopCarBuyProductNumberDidChange", name: LFBShopCarBuyProductNumberDidChangeNotification, object: nil)
    }
    
    func shopCarBuyProductNumberDidChange() {
        if productsVC.productsTableView != nil {
            productsVC.productsTableView!.reloadData()
        }
    }
    
    // MARK:- Creat UI
    private func bulidCategoryTableView() {
        categoryTableView = LFBTableView(frame: CGRectMake(0, 0, ScreenWidth * 0.25, ScreenHeight), style: .Plain)
        categoryTableView.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        categoryTableView.hidden = true;
        view.addSubview(categoryTableView)
    }
    
    private func bulidProductsViewController() {
        productsVC = ProductsViewController()
        productsVC.delegate = self
        productsVC.view.hidden = true
        addChildViewController(productsVC)
        view.addSubview(productsVC.view)
        
        weak var tmpSelf = self
        productsVC.refreshUpPull = {
            let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.2 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                Supermarket.loadSupermarketData { (data, error) -> Void in
                    if error == nil {
                        tmpSelf!.supermarketData = data
                        tmpSelf!.productsVC.supermarketData = data
                        tmpSelf?.productsVC.productsTableView?.mj_header.endRefreshing()
                        tmpSelf!.categoryTableView.reloadData()
                        tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
                    }
                }
            })
        }
    }
    
    private func loadSupermarketData() {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            weak var tmpSelf = self
            Supermarket.loadSupermarketData { (data, error) -> Void in
                if error == nil {
                    tmpSelf!.supermarketData = data
                    tmpSelf!.categoryTableView.reloadData()
                    tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Bottom)
                    tmpSelf!.productsVC.supermarketData = data
                    tmpSelf!.categoryTableViewIsLoadFinish = true
                    tmpSelf!.productTableViewIsLoadFinish = true
                    if tmpSelf!.categoryTableViewIsLoadFinish && tmpSelf!.productTableViewIsLoadFinish {
                        tmpSelf!.categoryTableView.hidden = false
                        tmpSelf!.productsVC.productsTableView!.hidden = false
                        tmpSelf!.productsVC.view.hidden = false
                        tmpSelf!.categoryTableView.hidden = false
                        SVProgressHUD.dismiss()
                        tmpSelf!.view.backgroundColor = QJLColor(239, g: 239, b: 239,a: 1)

                    }
                }
            }
        }
    }
    
    // MARK: - Private Method
    private func showProgressHUD() {
        SVProgressHUD.setBackgroundColor(QJLColor(230, g: 230, b: 230,a: 1))
        view.backgroundColor = UIColor.whiteColor()
        if !SVProgressHUD.isVisible() {
            SVProgressHUD.showWithStatus("正在加载中")
        }
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SupermarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = CategoryCell.cellWithTableView(tableView)
        cell.categorie = supermarketData!.data!.categories![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if productsVC != nil {
            productsVC.categortsSelectedIndexPath = indexPath
        }
    }
    
}

// MARK: - SupermarketViewController
extension SupermarketViewController: ProductsViewControllerDelegate {
    
    func didEndDisplayingHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section + 1, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
    
    func willDisplayHeaderView(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }


}

```

![超市.gif](http://upload-images.jianshu.io/upload_images/1754828-a08fb867ce91f6a8.gif?imageMogr2/auto-orient/strip)

###订单和消息

- 这个页面数据都是死的，都是加载本地的内容来实现的，


![Snip20160812_1.png](http://upload-images.jianshu.io/upload_images/1754828-fd273a78dfb0a3d5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



![订单和消息.gif](http://upload-images.jianshu.io/upload_images/1754828-7c8a17a8bac8ce50.gif?imageMogr2/auto-orient/strip)

##结束语
本次的单糖之说主要是Swift作品的开开端，做的还不算是比较正规，目的就是为了让大家多动手去坑自己，这样才会成长，其实自己可以照着项目写，代码可以慢慢理解。

##下载地址
http://git.oschina.net/www.skyheng.com/DanTang
