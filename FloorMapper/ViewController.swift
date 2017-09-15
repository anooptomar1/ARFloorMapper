//
//  ViewController.swift
//  FloorMapper
//
//  Created by floesch on 01.09.17.

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK: - UI Elements
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - ARKit Config Properties
    
    var screenCenter: CGPoint?
    var trackingFallbackTimer: Timer?

    let session = ARSession()
    let fallbackConfiguration = AROrientationTrackingConfiguration()

    let standardConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        return configuration
    }()
    
    // MARK: - Queues
    
    static let serialSceneKitQueue = DispatchQueue(label: "serialSceneKitQueue")
    // Create instance variable for more readable access inside class
    let serialSceneKitQueue: DispatchQueue = ViewController.serialSceneKitQueue
    
    // MARK: - Floor Map
    
    var floorMap : FloorMap!
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floorMap = FloorMap()
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Prevent the screen from being dimmed after a while.
        UIApplication.shared.isIdleTimerDisabled = true

        if ARWorldTrackingConfiguration.isSupported {
            // Start the ARSession.
            resetTracking()
        } else {
            // This device does not support 6DOF world tracking.
            let sessionErrorMsg = "This app requires world tracking. World tracking is only available on iOS devices with A9 processor or newer. " +
            "Please quit the application."
            displayMessage(title: "Unsupported platform", message: sessionErrorMsg)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup
    
    func setupScene() {
        sceneView.setup()
        sceneView.delegate = self
        sceneView.session = session
        sceneView.scene.enableEnvironmentMapWithIntensity(25, queue: serialSceneKitQueue)
        
//        sceneView.debugOptions = [.showWireframe]
        
        sceneView.scene.rootNode.addChildNode(floorMap)

        DispatchQueue.main.async {
            self.screenCenter = self.sceneView.bounds.mid
        }
    }
    
    // Mark: - Tracking
    
    func resetTracking() {
        session.run(standardConfiguration, options: [.resetTracking, .removeExistingAnchors])

        // reset timer
        if trackingFallbackTimer != nil {
            trackingFallbackTimer!.invalidate()
            trackingFallbackTimer = nil
        }
    }
    
    // MARK: - Error handling
    
    func displayMessage(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        dialog.addAction(okayAction)
        present(dialog, animated: false, completion: nil)
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            serialSceneKitQueue.async {
                self.addPlane(node: node, anchor: planeAnchor)
            }
        }
    }
    
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        if let planeAnchor = anchor as? ARPlaneAnchor {
//            serialSceneKitQueue.async {
//                self.updatePlane(anchor: planeAnchor)
//            }
//        }
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
//        if let planeAnchor = anchor as? ARPlaneAnchor {
//            serialSceneKitQueue.async {
//                self.removePlane(anchor: planeAnchor)
//            }
//        }
//    }
    
    // MARK: - Planes
    
//    var planes = [ARPlaneAnchor: Plane]()
    
    func addPlane(node: SCNNode,  anchor: ARPlaneAnchor) {
//        let plane = Plane(anchor)
//        planes[anchor] = plane
//        node.addChildNode(plane)
        floorMap.add(anchor)
    }
    
//    func updatePlane(anchor: ARPlaneAnchor) {
//        if let plane = planes[anchor] {
//            plane.update(anchor)
//        }
//    }
//
//    func removePlane(anchor: ARPlaneAnchor) {
//        if let plane = planes.removeValue(forKey: anchor) {
//            plane.removeFromParentNode()
//        }
//    }
}
