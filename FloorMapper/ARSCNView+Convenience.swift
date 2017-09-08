//
//  ARSCNView+Convenience.swift
//  FloorMapper
//
//  Created by Florian Schoeler on 01.09.17.
//  Copyright © 2017 Florian Schöler. All rights reserved.
//

import ARKit
import Foundation

extension ARSCNView {
    
    func setup() {
        antialiasingMode = .multisampling4X
        automaticallyUpdatesLighting = false
        
        preferredFramesPerSecond = 60
        contentScaleFactor = 1.3
        
        if let camera = pointOfView?.camera {
            camera.wantsHDR = true
            camera.wantsExposureAdaptation = true
            camera.exposureOffset = -1
            camera.minimumExposure = -1
            camera.maximumExposure = 3
        }
    }
}
