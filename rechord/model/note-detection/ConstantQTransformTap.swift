//
//  ConstantQTransformTap.swift
//  rechord
//
//  Created by Julian Tigler on 11/13/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation
import AudioKit

class ConstantQTransformTap: AggregatingTap {
    
    init(_ input: AKNode, minFrequency: Float, maxFrequency: Float, inputBufferSize: UInt32, bins: Int32, sampleFrequency: Float, analysisCompletionBlock: @escaping ([Float]) -> ()) {
        
        let cqt = CQTBridge(minFreq: minFrequency, maxFreq: maxFrequency, bins: bins, sampleFreq: sampleFrequency)!
        var transformedSignal = [Float](zeros: Int(cqt.getKeyCount()))
        
        super.init(input, inputBufferSize: 4096, aggregationFactor: 2) { (signal) in
            signal.withUnsafeBufferPointer { (unsafeBufferPointer) in
                if let transformed = cqt.run(withTimeDomainSignal: unsafeBufferPointer.baseAddress, signalLength: UInt32(signal.count)) {
                    for i in 0..<Int(cqt.getKeyCount()) {
                        transformedSignal[i] = transformed[i]
                    }
                    analysisCompletionBlock(transformedSignal)
                }
            }

        }
    }
}
