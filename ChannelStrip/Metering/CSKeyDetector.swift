//
//  CSKeyDetector.swift
//  ChannelStrip
//
//  Created by Pro on 05/02/2017.
//  Copyright © 2017 Olivier Lesnicki. All rights reserved.
//

import Foundation
import AudioKit

class CSKeyDetector : CSTuner {
    
    var timer : Timer?
    
    public init(node _: AKNode) {
        super.init(node)
        
        if (isStarted) {
            startTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(compute),
            userInfo: nil,
            repeats: true
        )
    }
    
    func stopTimer() {
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func compute() {
        
    }
    
    override func start() {
        startTimer()
        super.start()
    }
    
    override func stop() {
        stopTimer()
        super.stop()
    }
    
}
