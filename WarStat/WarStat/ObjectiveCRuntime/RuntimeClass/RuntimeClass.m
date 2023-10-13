//
//  RuntimeObject.m
//  WarStat
//
//  Created by a.antoniak on 21.09.2023.
//

#import "RuntimeClass.h"
#import <objc/runtime.h>

@interface RuntimeClass ()
@property Class runtimeClass;
- (void)createNewClass;
@end

@implementation RuntimeClass

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createNewClass];
    }
    return self;
}

- (void)createNewClass {
    // New class allocation
    Class newRuntimeClass = objc_allocateClassPair([NSObject class], "RuntimeClassExample", 0);
    
    // Counter
    class_addIvar(newRuntimeClass, "counter", sizeof(NSInteger), log2(_Alignof(NSInteger)), @encode(NSInteger));
    Ivar counterIvar = class_getInstanceVariable(newRuntimeClass, "counter");
    ptrdiff_t counterOffset = ivar_getOffset(counterIvar);
    
    // Initializer
    SEL initSelector = NSSelectorFromString(@"init");
    IMP initIMP = imp_implementationWithBlock(^(id self) {
        NSInteger defaultValue = 0;
        NSLog(@"Init function, Default counter value - %ld", (long)defaultValue);
        char *counterPtr = ((char *)(__bridge void *)self) + counterOffset;
        memcpy(counterPtr, &defaultValue, sizeof(defaultValue));
        return self;
    });
    class_addMethod(newRuntimeClass, initSelector, initIMP, nil);

    // Incrementer
    SEL incrementSelector = NSSelectorFromString(@"increment");
    IMP increaseCounterIMP = imp_implementationWithBlock(^(id self) {
        char *counterPtr = ((char *)(__bridge void *)self) + counterOffset;
        NSInteger counter;
        memcpy(&counter, counterPtr, sizeof(counter));
        NSLog(@"increment function, Old counter value - %ld", (long)counter);
        
        counter +=1;
        
        NSLog(@"increment function, New counter value - %ld", (long)counter);
        memcpy(counterPtr, &counter, sizeof(counter));
    });
    class_addMethod(newRuntimeClass, incrementSelector, (IMP)increaseCounterIMP, nil);

    // Getter
    SEL igetCounterSelector = NSSelectorFromString(@"getCounter");
    IMP getCounterIMP = imp_implementationWithBlock(^(id self) {
        char *counterPtr = ((char *)(__bridge void *)self) + counterOffset;
        NSInteger counter;
        memcpy(&counter, counterPtr, sizeof(counter));
        NSLog(@"Get counter function: %lu", (long)counter);
        return counter;
    });
    class_addMethod(newRuntimeClass, igetCounterSelector, (IMP)getCounterIMP, nil);
    
    // New class registarion
    objc_registerClassPair(newRuntimeClass);
    
    // New class saving
    _runtimeClass = newRuntimeClass;
}

- (void)run {
    id instanceOfNewClass = [[_runtimeClass alloc] init];
    
    SEL incrementSelector = NSSelectorFromString(@"increment");
    SEL getCounterSelector = NSSelectorFromString(@"getCounter");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [instanceOfNewClass performSelector:incrementSelector];
    [instanceOfNewClass performSelector:incrementSelector];
    [instanceOfNewClass performSelector:incrementSelector];
    NSInteger counter = (NSInteger)[instanceOfNewClass performSelector: getCounterSelector];
#pragma clang diagnostic pop
    
    NSLog(@"counter is %ld", (long)counter);
}

@end
