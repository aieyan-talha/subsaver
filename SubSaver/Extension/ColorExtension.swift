//
//  File.swift
//  SubSaver
//
//  Created by Winnie on 14/5/2023.
//

import UIKit
import SwiftUI

public extension Color {

    static func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> Color {
        Color(red: r  < 1 ? r  : r / 255.0,
              green: g < 1 ? g : g / 255.0,
              blue: b < 1 ? b : b / 255.0,
              opacity: a)
    }
}

