//
//  FloorMap.swift
//  FloorMapper
//
//  Created by floesch on 01.09.17.

import Foundation
import ARKit

class FloorMap: SCNNode {
    
    // MARK: - Properties
    
    var vertices = [SCNVector3]()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARKit
    
    func add(_ anchor: ARPlaneAnchor) {
//        if vertices.isEmpty {
//            setFirstPlane(anchor)
//            vertices.removeAll()
//        }

        // simply add one SCNPlane per ARPlaneAnchor
        let geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        geometry.materials.first?.diffuse.contents = UIColor(red: red, green: green, blue: blue, alpha: 0.6)
        let node = SCNNode(geometry: geometry)
        addChildNode(node)
        
//        if let plane = childNodes.first {
//            let geometry = plane.geometry as! SCNPlane
//            geometry.width = CGFloat(anchor.extent.x)
//            geometry.height = CGFloat(anchor.extent.z)
//            plane.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
//        }
    }
    
    private func setFirstPlane(_ anchor: ARPlaneAnchor) {
        let width = anchor.extent.x
        let height = anchor.extent.z
        let halfWidth = -width / 2.0
        let halfHeight = -height / 2.0
        
        let positionTopLeft = SCNVector3Make(-halfWidth, 0.0, -halfHeight)
        let positionTopRight = SCNVector3Make(halfWidth, 0.0, -halfHeight)
        let positionLowerLeft = SCNVector3Make(-halfWidth, 0.0, halfHeight)
        let positionLowerRight = SCNVector3Make(halfWidth, 0.0, halfHeight)
        vertices = [positionTopLeft, positionTopRight, positionLowerLeft, positionLowerRight]
        
        let indices : [UInt8] = [0,2,1, /**/ 1,2,3]
        
        let geometrySource = SCNGeometrySource(vertices: vertices)
        let geometryData = Data(bytes: indices)
        let geometryElement = SCNGeometryElement(data: geometryData, primitiveType: .triangles, primitiveCount: 2, bytesPerIndex: 1)
        let geometryPolygon = SCNGeometry(sources: [geometrySource], elements: [geometryElement])
        geometry = geometryPolygon
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        transform = SCNMatrix4(anchor.transform)
        
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        geometry?.materials.first?.diffuse.contents = UIColor(red: red, green: green, blue: blue, alpha: 0.6)
    }
    
    private func intersect(plane: ARPlaneAnchor) {
        
    }
}
