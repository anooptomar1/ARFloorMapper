import Foundation
import ARKit

class Plane: SCNNode {
    
    // MARK: - Properties
    
    var anchor: ARPlaneAnchor
    //var focusSquare: FocusSquare?
    
    // MARK: - Initialization
    
    init(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        
        let width = anchor.extent.x
        let height = anchor.extent.z
        let halfWidth = -width / 2.0
        let halfHeight = -height / 2.0
        
        let positionTopLeft = SCNVector3Make(-halfWidth, 0.0, -halfHeight)
        let positionTopRight = SCNVector3Make(halfWidth, 0.0, -halfHeight)
        let positionLowerLeft = SCNVector3Make(-halfWidth, 0.0, halfHeight)
        let positionLowerRight = SCNVector3Make(halfWidth, 0.0, halfHeight)
        let positions = [positionTopLeft, positionTopRight, positionLowerLeft, positionLowerRight]
        
        let indices : [UInt8] = [0,2,1, 1,2,3]
        
        let geometrySource = SCNGeometrySource(vertices: positions)
        
        let geometryData = Data(bytes: indices)
        let geometryElement = SCNGeometryElement(data: geometryData, primitiveType: .triangles, primitiveCount: 2, bytesPerIndex: 1)
        
        let geometryPolygon = SCNGeometry(sources: [geometrySource], elements: [geometryElement])
        
        let geometryPolygonNode = SCNNode(geometry: geometryPolygon)
        geometryPolygonNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        geometryPolygon.materials.first?.diffuse.contents = UIColor(red: red, green: green, blue: blue, alpha: 0.6)
        
        addChildNode(geometryPolygonNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARKit
    
    func update(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
        
//        if let plane = childNodes.first {
//            let geometry = plane.geometry as! SCNPlane
//            geometry.width = CGFloat(anchor.extent.x)
//            geometry.height = CGFloat(anchor.extent.z)
//            plane.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
//        }
    }
    
}
