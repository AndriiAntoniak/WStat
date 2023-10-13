//
//  ObjcRandomizer.m
//  WarStat
//
//  Created by a.antoniak on 14.09.2023.
//

#import "ObjcRandomizer.h"

@implementation ObjcRandomizer

- (NSNumber *)getRandomNumber {
    return @([self getRandomNumberFrom:0 to:100]);
//    return [self getRandomNumberFrom:0 to:100];
}

- (NSInteger)getRandomNumberFrom:(uint32_t)min to:(uint32_t)max {
    return (NSInteger)(min + arc4random_uniform(max - min + 1));
}

//- (NSInteger)getSwiftyRandomNumber {
//    Randomizer *swiftRandomizer = [[Randomizer alloc] init];
//}

@end
