//
//  ViewController.swift
//  UpButton
//
//  Created by Павел Попов on 24/05/2019.
//  Copyright © 2019 Yopi Studio. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
        avPlayer?.play()
        paused = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theURL = Bundle.main.url(forResource:"VIDEO_NAME", withExtension: "mp4") //VIDEO_TYPE -> MP4
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        addPlayerNotifications()
    }
    
    deinit {
        removePlayerNotifations()
    }
    
    func addPlayerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func removePlayerNotifations() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero) { (finished) in
            if(finished){
                print("Ok")
            }
            else {
                // How to get the player to play again??
            }
        }
    }
    
    
    //App enter in forground.
    @objc func applicationWillEnterForeground(_ notification: Notification) {
        paused = false
        avPlayer?.play()
    }
    
    //App enter in forground.
    @objc func applicationDidEnterBackground(_ notification: Notification) {
        paused = true
        avPlayer?.pause()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }

}

