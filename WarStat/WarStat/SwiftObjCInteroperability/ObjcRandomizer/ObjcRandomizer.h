//
//  ObjcRandomizer.h
//  WarStat
//
//  Created by a.antoniak on 14.09.2023.
//

#import <Foundation/Foundation.h>

@interface ObjcRandomizer : NSObject
- (nullable NSNumber *)getRandomNumber;
- (NSInteger)getRandomNumberFrom:(uint32_t)from to:(uint32_t)to;

NS_ASSUME_NONNULL_BEGIN

- (NSArray<NSNumber *> *)getRandomNumbers;
- (void) alculateWithCompletion:(NSNumber * (^_Nonnull)(void))finishBlock;

NS_ASSUME_NONNULL_END

- (NSInteger)getSwiftyRandomNumber;
@end

