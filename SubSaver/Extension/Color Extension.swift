//
//  Color Extension.swift
//  SubSaver
//
//  Created by Winnie on 13/5/2023.
//

import Foundation
import UIKit
import SwiftUI

public extension Color {

    static func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> Color {
        Color(red: r / 255.0, green: g / 255.0, blue: b / 255.0)
    }
}
