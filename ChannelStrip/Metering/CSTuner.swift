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
    
    let allNoteFrequencies : [Double] = [16.35,17.32,18.35,19.45,20.6,21.83,23.12,24.5,25.96,27.5,29.14,30.87]
    let allNoteNames : [Key] = [Key.c, Key.cSharp,Key.d,Key.dSharp,Key.e,Key.f,Key.fSharp,Key.g,Key.gSharp,Key.a,Key.aSharp,Key.b]
    
    var noteFrequencies : [Double]!
    var noteNames : [Key]!
    
    class Tune {
        open var note: Key!
        open var octave: Int!
        open var offset: Double!
        
        init(note: Key, octave: Int, offset: Double) {
            self.note = note
            self.octave = octave
            self.offset = offset
        }
    }
    
    enum Scale {
        case major
        case minor
        case chromatic
    }
    
    enum Key {
        case c
        case cSharp
        case d
        case dSharp
        case e
        case f
        case fSharp
        case g
        case gSharp
        case a
        case aSharp
        case b
    }
    
    public init(_ node: AKNode, scale: Scale = .chromatic, key: Key = .c) {
        super.init(node)
        setScaleAndKey(scale, key: key)
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
            
            let note = noteNames[index]
            let octave = Int(log2f(Float(self.frequency) / frequency))
            let offset = 12 * log2f(frequency / Float(noteFrequencies[index]))

            return Tune(note: note, octave: octave, offset: offset)

        } else {
            return nil
        }

    }

    
    func setScaleAndKey(_ scale: Scale = .chromatic, key: Key = .c) {
        
        var pattern : [Int] = []
        
        noteNames = []
        noteFrequencies = []
        
        switch scale {
        
        case .major:
            pattern = [0, 2, 4, 5, 7, 9, 11]
            break
        
        case .minor:
            pattern = [0, 2, 3, 5, 7, 8, 10]
            break
        
        case .chromatic:
            pattern = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
            break
            
        }
        
        var index = 0
        
        for i in 0..<allNoteNames.count {
            if (allNoteNames[i] == key) {
                index = i
            }
        }
        
        for i in pattern {
            noteNames.append(allNoteNames[(index + i) % allNoteNames.count])
            noteFrequencies.append(allNoteFrequencies[(index + i) % allNoteFrequencies.count])
        }
        
        
    }
    
}
