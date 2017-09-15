//
//  CGRect+Convenience.swift
//  FloorMapper
//
//  Created by floesch on 01.09.17.

import CoreGraphics
import Foundation

extension CGRect {
    var mid: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
