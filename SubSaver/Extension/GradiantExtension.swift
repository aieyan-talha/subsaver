//
//  File.swift
//  SubSaver
//
//  Created by Winnie on 14/5/2023.
//

import Foundation
import SwiftUI

extension RadialGradient {
    
    /// background color RadialGradient
    /// RGBA(0.176, 0.424, 0.875)
    static var pageBackgroundRadialGradient: RadialGradient {
        let backgroundColorGradient = RadialGradient(
            gradient: Gradient(colors: [.RGBA(0.176, 0.424, 0.875),
                                        Color.white.opacity(0)]),
            center: .center,
            startRadius: 0,
            endRadius: 500)
        return backgroundColorGradient
    }
    
}



extension LinearGradient {
    
    /// Background color LinearGradient
    /// RGBA(0.282, 0.184, 0.969, 0.75)
    /// RGBA(0.176, 0.424, 0.875, 0.65)
    static var pageBackgroundLinearGradient: LinearGradient {
        let backgroundColorGradient = LinearGradient(
            gradient: Gradient(colors: [.RGBA(0.282, 0.184, 0.969, 0.75),
                                        .RGBA(0.176, 0.424, 0.875, 0.65)]),
            startPoint: .leading, endPoint: .trailing)
        return backgroundColorGradient
    }
}
