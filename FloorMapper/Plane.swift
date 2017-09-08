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
        
        let geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        geometry.materials.first?.diffuse.contents = UIColor(red: red, green: green, blue: blue, alpha: 0.6)
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        geometryNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0.0, 0.0)
        
        addChildNode(geometryNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARKit
    
    func update(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
        
        if let plane = childNodes.first {
            let geometry = plane.geometry as! SCNPlane
            geometry.width = CGFloat(anchor.extent.x)
            geometry.height = CGFloat(anchor.extent.z)
            plane.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        }
    }
    
}
