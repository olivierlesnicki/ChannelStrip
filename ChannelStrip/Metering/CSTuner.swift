//
//  CSTuner.swift
//  ChannelStrip
//
//  Created by Pro on 05/02/2017.
//  Copyright © 2017 Olivier Lesnicki. All rights reserved.
//

import Foundation
import AudioKit

class CSTuner : AKFrequencyTracker {
    
    let noteFrequencies = [16.35,17.32,18.35,19.45,20.6,21.83,23.12,24.5,25.96,27.5,29.14,30.87]
    let noteNamesWithSharps = ["C", "C♯","D","D♯","E","F","F♯","G","G♯","A","A♯","B"]
    
    class Tune {
        open var note: String!
        open var octave: Int!
        open var offset: Double!
        
        init(note: String, octave: Int, offset: Double) {
            self.note = note
            self.octave = octave
            self.offset = offset
        }
    }
    
    open var tune : CSTuner.Tune? {
        
        if self.amplitude > 0.1 {
            
            var frequency = Float(self.frequency)
            while (frequency > Float(noteFrequencies[noteFrequencies.count-1])) {
                frequency = frequency / 2.0
            }
            while (frequency < Float(noteFrequencies[0])) {
                frequency = frequency * 2.0
            }
            
            var minDistance: Float = 10000.0
            var index = 0
            
            for i in 0..<noteFrequencies.count {
                let distance = fabsf(Float(noteFrequencies[i]) - frequency)
                if (distance < minDistance){
                    index = i
                    minDistance = distance
                }
            }
            
            let note = noteNamesWithSharps[index]
            let octave = Int(log2f(Float(self.frequency) / frequency))
            let offset = 12 * log2f(frequency / Float(noteFrequencies[index]))

            return Tune(note: note, octave: octave, offset: offset)

        } else {
            return nil
        }

    }
    
}
