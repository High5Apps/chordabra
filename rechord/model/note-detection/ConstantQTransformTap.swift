//
//  ConstantQTransformTap.swift
//  rechord
//
//  Created by Julian Tigler on 11/13/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation
import AudioKit

class ConstantQTransformTap: NSObject {
    
    init(_ input: AKNode, minFrequency: Float, maxFrequency: Float, inputBufferSize: UInt32, bins: Int32, sampleFrequency: Float, analysisCompletionBlock: @escaping ([Float]) -> ()) {
        
        let cqt = CQTBridge(minFreq: minFrequency, maxFreq: maxFrequency, bins: bins, sampleFreq: sampleFrequency)!
        var transformedSignal = [Float](zeros: Int(cqt.getKeyCount()))
        
        input.avAudioUnitOrNode.installTap(onBus: 0, bufferSize: inputBufferSize, format: AudioKit.format) { (buffer, when) -> () in
            buffer.frameLength = inputBufferSize
            let offset = Int(buffer.frameCapacity - buffer.frameLength)

            if let tail = buffer.floatChannelData?[0], let transformed = cqt.run(withTimeDomainSignal: &tail[offset], signalLength: inputBufferSize) {
                for i in 0..<Int(cqt.getKeyCount()) {
                    transformedSignal[i] = transformed[i]
                }
                analysisCompletionBlock(transformedSignal)
            }
        }
    }
}
