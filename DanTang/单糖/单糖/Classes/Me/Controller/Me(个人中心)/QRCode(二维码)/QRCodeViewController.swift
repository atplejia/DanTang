//
//  QRCodeViewController.swift
//  单糖
//
//  Created by 金亮齐 on 16/8/3.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

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
