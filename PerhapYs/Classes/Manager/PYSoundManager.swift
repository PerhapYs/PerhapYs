//
//  PYSoundManager.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/19.
//

import UIKit
import AVFAudio

class PYSoundManager: NSObject {

    var player : AVAudioPlayer?
    var audioPath : String?
    var isLoop : Bool = false
    
    func play(with path:String , isLoop:Bool){
        
        self.audioPath = path
        self.isLoop = isLoop
        
        if let player = player,player.isPlaying {
            player.stop()
            self.player = nil
        }
        UIDevice.current.isProximityMonitoringEnabled = true
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        guard let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) else{
            return
        }
        guard let player = try? AVAudioPlayer.init(data: data)  else {
            return
        }
        self.player = player
        player.delegate = self
        player.setVolume(1.0, fadeDuration: 2)
        player.currentTime = 0
        player.numberOfLoops = 0
        player.isMeteringEnabled = true
        player.updateMeters()
        
        if player.prepareToPlay(){
            player.play()
        }
    }
    func rePlay(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {[weak self] in
            guard let weakSelf = self else {
                return
            }
            guard weakSelf.player != nil else{
                return
            }
            guard let path = weakSelf.audioPath else {
                return
            }
            weakSelf.play(with: path, isLoop: true)
        }
    }
    func stop(){
        
        guard let player = self.player else {
            return
        }
        self.isLoop = false
        player.stop()
        self.player = nil
    }
}
extension PYSoundManager : AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if self.isLoop{
            self.rePlay()
        }
    }
}
