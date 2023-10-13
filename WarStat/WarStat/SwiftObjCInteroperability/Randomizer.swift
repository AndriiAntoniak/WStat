//
//  Randomizer.swift
//  WarStat
//
//  Created by a.antoniak on 14.09.2023.
//

import Foundation

struct Randomizer {
    func getRandomNumber(from min: Int = 0, to max: Int = 100) -> Int {
        min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}
