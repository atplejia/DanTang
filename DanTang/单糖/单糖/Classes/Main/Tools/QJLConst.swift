//
//  QJLConst.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

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


let IID = 5034850950
let device_id = 6096495334
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


