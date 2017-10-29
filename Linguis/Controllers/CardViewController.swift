//
//  CardViewController.swift
//  Linguis

//  Created by Forrest on 10/28/17.
//  Copyright © 2017 Forrest. All rights reserved.
//

import UIKit
import SceneKit
import ARKit


class CardViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "1to2", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        
        // Create a new scene
//        let scene = SCNScene(named: "ship.scn")!
        //let scene = SCNScene(named: "art.scnassets/pumpkin/Pumpkin.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print(error)
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print(camera.trackingState)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                if node.name == "shipship" {
                    node.runAction(SCNAction.moveBy(x: 0, y: 1.1, z: 1.5, duration: 1.7))
                    
                    let source = SCNAudioSource(fileNamed: "art.scnassets/Plane_sound.m4a")
                    let action = SCNAction.playAudio(source!, waitForCompletion: true)
                    node.runAction(action)
                    
                }
            }
            
        }
    }
    
    
}

