//
//  FloatExtension.swift
//  SubSaver
//
//  Created by Winnie on 13/5/2023.
//

import Foundation
import SwiftUI


public extension CGFloat {
    static var screenWidth: CGFloat {
        let width: CGFloat = UIScreen.main.bounds.width
        return width
    }
    
    static var screenHeight: CGFloat {
        let height: CGFloat = UIScreen.main.bounds.height
        return height
    }
}
