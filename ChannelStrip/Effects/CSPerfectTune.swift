//
//  CSKeyDetector.swift
//  ChannelStrip
//
//  Created by Pro on 05/02/2017.
//  Copyright © 2017 Olivier Lesnicki. All rights reserved.
//

import Foundation
import AudioKit

class CSPerfectTune : CSTuner {
    
    var timer : Timer?
    var pitcher : AKPitchShifter?
    
    public init(_ node: AKNode) {
        super.init(node)
        
        pitcher = AKPitchShifter(node)
        setScaleAndKey(.major, key: .c)
        
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
        if tune != nil {
            pitcher?.shift = -(tune?.offset)!
        }
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
