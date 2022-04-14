//
//  VerificationCodeButton.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/17.
//

import UIKit

typealias sendCodeSuccessBlock = () -> ()

let Time_countDown_num = 60

class VerificationCodeButton: UIButton {

    var timer : Timer?
    var totalTimerNum : Int = Time_countDown_num
    
    var clickBlock : ((@escaping sendCodeSuccessBlock) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initializeInterface()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.initializeInterface()
    }
    
    func initializeInterface()  {
        
        self.backgroundColor = COLOR_7332FF
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitle("发送验证码", for: .normal)
        self.layer.cornerRadius = 10.F()
        self.layer.masksToBounds = true
        self.setTitleColor(UIColor.white, for: .disabled)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addTarget(self, action: #selector(sendCodeEvent), for: .touchUpInside)
    }
    
    override var intrinsicContentSize: CGSize{
        
        return CGSize.init(width: 136.F(), height: 48.F())
    }
    internal override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
    }

    @objc func sendCodeEvent (){
        
        guard let block = self.clickBlock else {
        
            return
        }
        
        let startBlock : sendCodeSuccessBlock = {
            self.isEnabled = false
            self.startTimer()
        }
        block(startBlock)
    }
    
    //MARK: NSTimer
    func startTimer() {
        
        totalTimerNum = Time_countDown_num
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        
        if timer != nil{
         
            timer?.invalidate()
        }
    }
    
    @objc func timerEvent (){
        
        if self.superview == nil {
            self.stopTimer()
            return
        }
        
        if totalTimerNum < 0 {
            self.stopTimer()
            self.isEnabled = true
            return
        }
    
        let title = "倒计时" + String(totalTimerNum)
        self.setTitle(title, for: .disabled)
        totalTimerNum-=1
    }
    deinit{
        
        print("销毁")
    }
}
