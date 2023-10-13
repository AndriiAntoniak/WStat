//
//  MemoryLayout.swift
//  WarStat
//
//  Created by a.antoniak on 21.09.2023.
//

import Foundation

enum SwiftMemoryLayout {
    static func run() {
        print("🛠️ Exam \n")
        MemoryLayout<Exam>.printAll()
        MemoryLayout<ExamReversed>.printAll()
        print("=================================== \n")
        
        print("🛠️ ExamAlternative \n")
        MemoryLayout<ExamAlternative>.printAll()
        MemoryLayout<ExamAlternativeReversed>.printAll()
        print("=================================== \n")
        
        print("🛠️ ExamCustom \n")
        MemoryLayout<ExamCustom>.printAll()
        MemoryLayout<ExamCustomReversed>.printAll()
        print("=================================== \n")
        
        print("🛠️ String \n")
        MemoryLayout<String>.printAll()
        print("=================================== \n")
        
        print("🛠️ MARK \n")
        MemoryLayout<Mark>.printAll()
        MemoryLayout<MarkAlternative>.printAll()
        print("=================================== \n")
        
        let goodMark = Mark.b
        let goodMarkAlt = MarkAlternative.b
        print("🛠️ Good Mark(\(goodMark) size - \(MemoryLayout.size(ofValue: goodMark)) \n")
        print("🛠️ Good Mark Alternative (\(goodMarkAlt)) size - \(MemoryLayout.size(ofValue: goodMarkAlt)) \n")
        
        print("🛠️ MARK \n")
        MemoryLayout<ExamClass>.printAll()
        MemoryLayout<ExamClassReversed>.printAll()
        print("=================================== \n")
        
        let exam = ExamClass()
        let reversedExam = ExamClassReversed()
        print("🛠️ Exam Class \n")
        print("Size of ExamClass - \(class_getInstanceSize(ExamClass.self))")
        print("Size of ExamClassReversed - \(class_getInstanceSize(ExamClassReversed.self))")
        print("=================================== \n")
        
        print("🛠️ Exam \n")
        MemoryLayout<Exam>.printAll()
        MemoryLayout<ExamReversed>.printAll()
        print("=================================== \n")
    }
}

private extension SwiftMemoryLayout {
    enum Mark {
        case a, b, c, d, e
    }
    
    enum MarkAlternative: String {
        case a = "A", b = "B", c = "C", d = "D", e = "E"
        
        var asNumber: Int {
            switch self {
            case .a:
                return 5
            case .b:
                return 4
            case .c:
                return 3
            case .d:
                return 2
            case .e:
                return 1
            }
        }
    }
    
    struct Exam {
        let mark: Int
        let mark1: Int
        let isPassed: Bool
    }
    
    struct ExamReversed {
        let isPassed: Bool
        let mark: Int
    }
    
    struct ExamAlternative {
        let mark: String
        let isPassed: Bool
    }
    
    struct ExamAlternativeReversed {
        let isPassed: Bool
        let mark: String
    }
    
    struct ExamCustom {
        let mark: Mark
        let isPassed: Bool
    }
    
    struct ExamCustomReversed {
        let isPassed: Bool
        let mark: Mark
    }
    
    class ExamClass {
//        let mark: Int = 4
//        let mark1: Int = 5
        let isPassed: Bool = true
    }
    
    class ExamClassReversed {
        let isPassed: Bool = true
        let mark: Int = 4
    }
}

private extension MemoryLayout {
    static func printAll() {
        print("+_____________________________________________+")
        print("| 🛠️ MemoryLayout of type - \(T.self):")
        print("| 🛠️ size: - \(Self<T>.size)")
        print("| 🛠️ stride: - \(Self<T>.stride)")
        print("| 🛠️ alignment: - \(Self<T>.alignment)")
        print("+_____________________________________________+")
        print("\n")
    }
}
