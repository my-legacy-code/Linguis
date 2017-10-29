//
//  ViewController.swift
//  Linguis
//
//  Created by Yang Liu on 10/28/17.
//  Copyright © 2017 Harry Liu. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet weak var sessionInfoLabel: UILabel!
    @IBOutlet weak var sessionInfoView: UIVisualEffectView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBAction func resetToOriginalState (sender: UIButton) {
        textLabel1.frame.origin.x = oldLabelPosition1
        textLabel1.textColor = UIColor.white
        textLabel1.layer.shadowColor = UIColor.black.cgColor
        textLabel1.layer.shadowOpacity = 1
        textLabel1.layer.shadowOffset = CGSize.zero
        textLabel1.layer.shadowRadius = 10
        
        textLabel2.frame.origin.x = oldLabelPosition2
        textLabel2.textColor = UIColor.white
        textLabel2.layer.shadowColor = UIColor.black.cgColor
        textLabel2.layer.shadowOpacity = 1
        textLabel2.layer.shadowOffset = CGSize.zero
        textLabel2.layer.shadowRadius = 10
        
        textLabel3.frame.origin.x = oldLabelPosition3
        textLabel3.textColor = UIColor.white
        textLabel3.layer.shadowColor = UIColor.black.cgColor
        textLabel3.layer.shadowOpacity = 1
        textLabel3.layer.shadowOffset = CGSize.zero
        textLabel3.layer.shadowRadius = 10
    }
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    var locLabel = -1
    var labelPosition1 = CGFloat(0)
    var labelPosition2 = CGFloat(0)
    var labelPosition3 = CGFloat(0)
    var oldLabelPosition1 = CGFloat(0)
    var oldLabelPosition2 = CGFloat(0)
    var oldLabelPosition3 = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        // Configure ARKit
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        oldLabelPosition1 = textLabel1.frame.origin.x
        oldLabelPosition2 = textLabel2.frame.origin.x
        oldLabelPosition3 = textLabel3.frame.origin.x
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(userDragged))
        
        textLabel1.addGestureRecognizer(gesture)
        textLabel1.isUserInteractionEnabled = true
        let gesture2 = UIPanGestureRecognizer(target: self, action: #selector(userDragged))
        textLabel2.addGestureRecognizer(gesture2)
        textLabel2.isUserInteractionEnabled = true
        let gesture3 = UIPanGestureRecognizer(target: self, action: #selector(userDragged))
        textLabel3.addGestureRecognizer(gesture3)
        textLabel3.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sceneView.session.pause()
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        updateSessionInfo(trackingState: camera.trackingState)
    }
    
    private func updateSessionInfo(trackingState: ARCamera.TrackingState) {
        let message: String
        
        switch trackingState {
        case .normal:
            message = ""
            
        case .notAvailable:
            message = "Tracking unavailable."
            
        case .limited(.excessiveMotion):
            message = "Tracking limited - Move the device more slowly."
            
        case .limited(.insufficientFeatures):
            message = "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions."
            
        case .limited(.initializing):
            message = "Initializing AR session."
        }
        
        sessionInfoLabel.text = message
//        sessionInfoView.isHidden = message.isEmpty
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func userDragged(gesture: UIPanGestureRecognizer) {
        print("Dragging")
        print(gesture.view)
        var loc = gesture.location(in: self.view)
        loc.y = gesture.view!.center.y
        gesture.view!.center = loc
        
        labelPosition1 = textLabel1.frame.origin.x
        labelPosition2 = textLabel2.frame.origin.x
        labelPosition3 = textLabel3.frame.origin.x
//        print(labelPosition1)
        correctLabelPosition()
        
    }
    
    @objc func correctLabelPosition() {
        if (labelPosition1 < labelPosition2 && labelPosition2 < labelPosition3) {
            textLabel1.textColor = UIColor.green
            textLabel2.textColor = UIColor.green
            textLabel3.textColor = UIColor.green
        }
    }

}

