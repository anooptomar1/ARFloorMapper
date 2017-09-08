//
//  CGRect+Convenience.swift
//  FloorMapper
//
//  Created by Florian Schoeler on 01.09.17.
//  Copyright © 2017 Florian Schöler. All rights reserved.
//

import CoreGraphics
import Foundation

extension CGRect {
    var mid: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
