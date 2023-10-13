//
//  SwiftObjCInteroperability.swift
//  WarStat
//
//  Created by a.antoniak on 21.09.2023.
//

import Foundation

enum SwiftObjCInteroperability {
    static func run() {
        let swiftRandomizer = Randomizer()
        let objcRandomizer = ObjcRandomizer()
        
        print("Swift")
        print("Random number(0-100): - \(swiftRandomizer.getRandomNumber())")
        print("Random number(5-100): - \(swiftRandomizer.getRandomNumber(from: 5))")
        
        print("Objective-C")
        print("Random number(0-100): - \(objcRandomizer.getRandomNumber())")
        print("Random number(5-10): - \(objcRandomizer.getRandomNumber(from: 5, to: 10))")
        
        let numbers = objcRandomizer.getRandomNumbers()
    }
}
