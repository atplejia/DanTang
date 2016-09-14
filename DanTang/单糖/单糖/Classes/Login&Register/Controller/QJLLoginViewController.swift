//
//  QJLLoginViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/2.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import SVProgressHUD
class QJLLoginViewController: QJLBaseViewController,TencentSessionDelegate {
      var _tencentOAuth:TencentOAuth!

    /// 手机号
    @IBOutlet weak var mobileField: UITextField!
    /// 密码
    @IBOutlet weak var passwordField: UITextField!
    /// 登录按钮
    @IBOutlet weak var loginButton: UIButton!
    /// 忘记密码按钮
    @IBOutlet weak var forgetPwdBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        _tencentOAuth = TencentOAuth.init(appId: "1105346506", andDelegate: self)
        // 设置导航栏的左右按钮
        setupBarButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func loginButtonClick(sender: UIButton) {
        
        SVProgressHUD.showWithStatus("正在登陆中")
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            SVProgressHUD.showSuccessWithStatus("登录成功")
        })
     
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: isLogin)
    }
    
    // MARK: - 设置导航栏按钮
    private func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(cancelButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: #selector(regiisterButtonClick))
    }
    
    /// 取消按钮点击
    func cancelButtonClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /// 注册按钮点击
    func regiisterButtonClick() {
        let registerVC = QJLRegisterViewController()
        registerVC.title = "注册"
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    /// - 其他社交账号登录
    @IBAction func otherLoginButtonClick(sender: UIButton) {
        if let buttonType = QJLOtherLoginButtonType(rawValue: sender.tag) {
            switch buttonType {
            case .weiboLogin:
                
                break
            case .weChatLogin:
                
                break
            case .QQLogin:
                //设置权限列表
                let permissions = ["get_user_info","get_simple_userinfo"];
                //登陆
                _tencentOAuth.authorize(permissions)
                
                break
            }
        }
    }
    //登陆完成调用
    func tencentDidLogin() {
        if !_tencentOAuth.accessToken.isEmpty {
            print("----------------------------------------")
            print("登录成功！")
            print("openId：\(_tencentOAuth.openId)",
                  "accessToken：\(_tencentOAuth.accessToken)",
                  "expirationDate：\(_tencentOAuth.expirationDate)")
            print("开始获取用户资料")
            _tencentOAuth.getUserInfo()
        }else {
            print("登录失败！没有获取到accessToken")
        }
    }
    
    /**
     * 登录失败后的回调
     */
    func tencentDidNotLogin(cancelled:Bool) {
        if cancelled {
            print("用户取消登录!")
        }else{
            print("登录失败!")
        }
    }
    
    /**
     * 登录时网络有问题的回调
     */
    func tencentDidNotNetWork() {
        print("没有网络，无法登录!")
    }
    
    /**
     * 取得用户信息的回调
     */
    func getUserInfoResponse(response:APIResponse) {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            SVProgressHUD.showSuccessWithStatus("登录成功")
        })
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: isLogin)
        print("----------------------------------------")
        print("用户资料获取成功：")
        print(response.jsonResponse)
    }
    



}
