//
//  ViewController.swift
//  嘟嘟嘟
//
//  Created by 徐建峰 on 2018/6/15.
//  Copyright © 2018年 Jianfeng Xu. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class ViewController: UIViewController {
    
    let imgView: UIImageView = UIImageView(frame: CGRect(x: -20, y: 20, width: 375+20, height: 350))
    
    let textFild: UITextField = UITextField(frame: CGRect(x: 20, y: 30, width: 350, height: 50))
    
    var arr: Array = [""]
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let vudioPath = Bundle.main.path(forResource: "猪之歌", ofType: "mp3")
        let pathURL=NSURL(fileURLWithPath: vudioPath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pathURL as URL)
        } catch {
            audioPlayer = nil
        }
        
        //   let session = AVAudioSession()
        //        do{
        //
        //            try session.setCategory(AVAudioSessionCategoryPlayback, with: [])
        //
        //            try session.setActive(true)
        //
        //        }catch{
        //
        //        }
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [[AVAudioSession, sharedInstance], overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
        //            })
        
        
        self.view.backgroundColor = UIColor.cyan
        
        let path = Bundle.main.path(forResource: "yaotou", ofType: "gif")
        let data = NSData(contentsOfFile: path!)
        
        let options: NSDictionary = [kCGImageSourceShouldCache as String: NSNumber(value: true), kCGImageSourceTypeIdentifierHint as String: ""]
        guard let imageSource = CGImageSourceCreateWithData(data!, options) else {
            return
        }
        // 获取gif帧数
        let frameCount = CGImageSourceGetCount(imageSource)
        var images = [UIImage]()
        
        var gifDuration = 0.0
        
        for i in 0 ..< frameCount {
            // 获取对应帧的 CGImage
            guard let imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, options) else {
                return
            }
            if frameCount == 1 {
                // 单帧
                gifDuration = Double.infinity
            } else{
                // gif 动画
                // 获取到 gif每帧时间间隔
                guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) , let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
                    let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else
                {
                    return
                }
                //                print(frameDuration)
                gifDuration += frameDuration.doubleValue
                // 获取帧的img
                let  image = UIImage(cgImage: imageRef, scale: UIScreen.main.scale, orientation: .up)
                // 添加到数组
                images.append(image)
            }
        }
        
        self.imgView.contentMode = .scaleAspectFit
        self.imgView.animationImages = images
        self.imgView.animationDuration = gifDuration
        self.imgView.animationRepeatCount = 0 // 无限循环
        self.imgView.startAnimating()
        
        
        self.view.addSubview(self.imgView)
        
        self.textFild.backgroundColor = UIColor.red
        self.textFild.delegate = self
        self.view.addSubview(self.textFild)
        
        let showBtn: UIButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-50, width: UIScreen.main.bounds.width, height: 50))
        showBtn.addTarget(self, action: #selector(ViewController.showBtnAction), for: .touchUpInside)
        // showBtn.backgroundColor = UIColor.black
        self.view.addSubview(showBtn)
        self.textFild.isHidden = true
        self.imgView.isHidden = true
        
        
    }
    
    @objc func showBtnAction() {
        
        self.imgView.isHidden = true
        
        self.textFild.isHidden = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.imgView.isHidden = true
        self.textFild.isHidden = true
        let alertController = UIAlertController(title: nil,
                                                message: arr.count == 7 ?arr[0]:"郭浩然是猪吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "是", style: .cancel, handler: {
            action in
            print("点击了确定")
            self.okButtonAction()
        })
        let okAction = UIAlertAction(title: "不是", style: .default, handler: {
            action in
            self.cancelButtonAction()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func okButtonAction() {
        
        let alertController = UIAlertController(title: nil,
                                                message: arr.count == 7 ?arr[1]:"你竟然是,我了个擦擦擦，你竟然是头猪！！！你会唱歌吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "会", style: .cancel, handler: {
            action in
            print("点击了确定")
            self.okButton1Action()
        })
        let okAction = UIAlertAction(title: "不会", style: .default, handler: {
            action in
            self.cancelButton1Action()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func cancelButtonAction() {
        
        
        let alertController = UIAlertController(title: nil,
                                                message: arr.count == 7 ?arr[2]:"那你知道‘红楼未完’吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "知道", style: .cancel, handler: {
            action in
            print("点击了确定")
            self.okButton2Action()
        })
        let okAction = UIAlertAction(title: "不知道", style: .default, handler: {
            action in
            self.cancelButton2Action()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func okButton1Action() {
        
        let alertController = UIAlertController(title: nil,
                                                message: arr.count == 7 ?arr[3]:"是猪之歌吧", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "是", style: .cancel, handler: {
            action in
            print("点击了确定")
            self.imgView.isHidden = false
            
            self.audioPlayer?.prepareToPlay()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                
            }
            //扬声器
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            self.audioPlayer?.play()
            
        })
        let okAction = UIAlertAction(title: "不是", style: .default, handler: {
            action in
            self.imgView.isHidden = false
            
            self.audioPlayer?.prepareToPlay()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                
            }
            //扬声器
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            self.audioPlayer?.play()
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func cancelButton1Action() {
        
        
        let alertController = UIAlertController(title: nil,
                                                message: arr.count == 7 ?arr[4]:"无聊那我给你唱一个啊！！！", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "是", style: .cancel, handler: {
            action in
            print("点击了确定")
            self.imgView.isHidden = false
            self.audioPlayer?.prepareToPlay()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                
            }
            
            //扬声器
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            self.audioPlayer?.play()
        })
        let okAction = UIAlertAction(title: "不是", style: .default, handler: {
            action in
            self.imgView.isHidden = false
            self.audioPlayer?.prepareToPlay()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                
            }
            //扬声器
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            self.audioPlayer?.play()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func okButton2Action() {
        
        let alertController = UIAlertController(title: nil,
                                                message: arr.count == 7 ?arr[5]:"好吧就是没看完，还有鲥鱼多刺,海棠无香", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "是", style: .cancel, handler: {
            action in
            print("点击了确定")
            self.imgView.isHidden = false
            
        })
        let okAction = UIAlertAction(title: "不是", style: .default, handler: {
            action in
            self.imgView.isHidden = false
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func cancelButton2Action() {
        
        let alertController = UIAlertController(title: nil,
                                                message: arr.count == 7 ?arr[6]:"就是红楼梦没看完！！！！", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "是", style: .cancel, handler: {
            action in
            print("点击了确定")
            self.imgView.isHidden = false
            
        })
        let okAction = UIAlertAction(title: "不是", style: .default, handler: {
            action in
            self.imgView.isHidden = false
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
}
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.arr = (textFild.text?.components(separatedBy: "@"))!
        
        return true
    }
    
    

}
