//
//  CQTBridge.mm
//  rechord
//
//  Created by Julian Tigler on 11/14/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQTBridge.h"
#import "CQT.hpp"

@implementation CQTBridge : NSObject

- (id)initWithMinFreq:(float)minFreq maxFreq:(float)maxFreq bins:(int)bins sampleFreq:(float)sampleFreq {
    self = [super init];

    CQTKit::CQT *cqt = new CQTKit::CQT(minFreq, maxFreq, bins, sampleFreq, CQTKit::WindowFunction::Hamming);
    self.cqtdata_mem = (void *)cqt;
    
    return self;
}

- (void)dealloc {
    CQTKit::CQT *cqt = (CQTKit::CQT *) self.cqtdata_mem;
    delete cqt;
}

- (float *)runWithTimeDomainSignal:(float *)x signalLength:(uint)n {
    CQTKit::CQT *cqt = (CQTKit::CQT *) self.cqtdata_mem;
    return cqt->forward(x, n);
}

- (int)getKeyCount {
    CQTKit::CQT *cqt = (CQTKit::CQT *) self.cqtdata_mem;
    return cqt->k();
}

@end


