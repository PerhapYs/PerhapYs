//
//  TimerManager.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2022/1/12.
//

import Foundation

class TimerManager{
    
    var timer : Timer?
    
    var runCount : Int = 120
    
    var timerInterval : TimeInterval = 1
    
    var timerRunBlock : ((Bool,Int) -> ())?
    
    private var selfRunCount : Int = 0
    
    func start(){
        
        self.stop()
        
        self.selfRunCount = runCount
        
        self.timer = Timer.scheduledTimer(timeInterval: self.timerInterval, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: .common)
    }
    
    func stop(){
        
        guard let unwapTimer = self.timer else {
            return
        }
        unwapTimer.invalidate()
        self.timer = nil
    }
    @objc func startTimer(){
        
        guard let block = self.timerRunBlock else {
            return
        }
        if runCount <= 0{
            block(false,self.selfRunCount)
            self.selfRunCount += 1
        }
        else{
            guard self.selfRunCount > 0 else {
                self.stop()
                block(true,self.selfRunCount)
                return
            }
            block(false,selfRunCount)
            self.selfRunCount -= 1
        }
    }
}
