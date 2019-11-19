//
//  AggregatingTap.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation
import AudioKit

class AggregatingTap: NSObject {
    init(_ input: AKNode, inputBufferSize: Int, aggregationFactor: Int, aggregateReadyBlock: @escaping ([Float]) -> ()) {
        
        var outputHolder = [Float](zeros: inputBufferSize * aggregationFactor)
        var frameIndex = 0
        
        input.avAudioUnitOrNode.installTap(onBus: 0, bufferSize: UInt32(inputBufferSize), format: AudioKit.format) { (buffer, when) -> () in
            buffer.frameLength = UInt32(inputBufferSize)
            let offset = Int(buffer.frameCapacity - buffer.frameLength)

            if let tail = buffer.floatChannelData?[0] {
                for i in 0..<Int(inputBufferSize) {
                    outputHolder[frameIndex * inputBufferSize + i] = tail[offset + i]
                }
                
                frameIndex += 1
                
                if frameIndex % aggregationFactor == 0 {
                    frameIndex = 0
                    aggregateReadyBlock(outputHolder)
                }
            }
        }
    }
}
