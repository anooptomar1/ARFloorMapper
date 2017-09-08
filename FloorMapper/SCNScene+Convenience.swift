//
//  SCNScene+Convenience.swift
//  FloorMapper
//
//  Created by Florian Schoeler on 01.09.17.
//  Copyright © 2017 Florian Schöler. All rights reserved.
//

import Foundation
import SceneKit

extension SCNScene {
    func enableEnvironmentMapWithIntensity(_ intensity: CGFloat, queue: DispatchQueue) {
        queue.async {
            if self.lightingEnvironment.contents == nil {
                if let environmentMap = UIImage(named: "Models.scnassets/sharedImages/environment_blur.exr") {
                    self.lightingEnvironment.contents = environmentMap
                }
            }
            self.lightingEnvironment.intensity = intensity
        }
    }
}
