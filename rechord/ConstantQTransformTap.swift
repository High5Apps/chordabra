//
//  ConstantQTransformTap.swift
//  rechord
//
//  Created by Julian Tigler on 11/13/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation
import AudioKit

protocol ConstantQTransformTapDelegate {
    func onInputBufferAnalyzed(powers: [Float])
}

class ConstantQTransformTap: NSObject {
    var constantQTransformTapDelegate: ConstantQTransformTapDelegate?
    
    private var inputBufferSize: UInt32!
    private var sampleRate: Float!
    private var cqt: CQTBridge!
    private var transformedSignal: [Float]!
    
    init(_ input: AKNode, minFrequency: Float, maxFrequency: Float, inputBufferSize: UInt32, sampleFrequency: Float = Float(AKSettings.sampleRate), bins: Int32 = 12) {
        super.init()
        
        self.inputBufferSize = inputBufferSize
        self.sampleRate = Float(AKSettings.sampleRate)
        
        self.cqt = CQTBridge(minFreq: minFrequency, maxFreq: maxFrequency, bins: bins, sampleFreq: self.sampleRate)
        self.transformedSignal = [Float](zeros: Int(self.cqt.getKeyCount()))
                
        input.avAudioUnitOrNode.installTap(onBus: 0, bufferSize: inputBufferSize, format: AudioKit.format) { [weak self] (buffer, _) -> Void in
            guard let strongSelf = self else {
                AKLog("Unable to create strong reference to self")
                return
            }

            buffer.frameLength = strongSelf.inputBufferSize
            let offset = Int(buffer.frameCapacity - buffer.frameLength)
            
            if let tail = buffer.floatChannelData?[0], let existingCQT = strongSelf.cqt {
                if let transformed = existingCQT.run(withTimeDomainSignal: &tail[offset], signalLength: strongSelf.inputBufferSize) {
                    for i in 0..<existingCQT.getKeyCount() {
                        strongSelf.transformedSignal[Int(i)] = transformed[Int(i)]
                    }
                    strongSelf.constantQTransformTapDelegate?.onInputBufferAnalyzed(powers: strongSelf.transformedSignal)
                }
            }
        }
    }
}
