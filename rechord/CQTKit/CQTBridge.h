#import <Foundation/Foundation.h>

@interface CQTBridge: NSObject

@property (nonatomic) void *cqtdata_mem;

- (id)initWithMinFreq:(float)minFreq maxFreq:(float)maxFreq bins:(int)bins sampleFreq:(float)sampleFreq;
- (float *)runWithTimeDomainSignal:(float *)x signalLength:(uint)n;
- (int)getKeyCount;

@end
