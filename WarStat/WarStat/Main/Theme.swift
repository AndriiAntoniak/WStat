//
//  Theme.swift
//  WarStat
//
//  Created by a.antoniak on 27.09.2023.
//

import Foundation
import SwiftUI

final class Theme: ObservableObject {
    private enum Padding: CGFloat {
        case vertical = 20
    }
    
    var verticalPadding: CGFloat { Padding.vertical.rawValue }
}

struct ThemeEnvironmentKey: EnvironmentKey {
    static var defaultValue = Theme()
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}
