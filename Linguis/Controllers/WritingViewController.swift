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

class WritingViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet weak var sessionInfoLabel: UILabel!
    @IBOutlet weak var sessionInfoView: UIVisualEffectView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var wordLabel: UITextField!
    
    var alertController: UIAlertController!
    var words: [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Configure ARKit
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Setup actionsheet
        words = [
            "human": "人",
            "cool": "酷",
            "ha": "哈",
            "hey": "嘿"
        ]
        alertController = UIAlertController(title: "What do you want to write?", message: nil, preferredStyle: .actionSheet)
        
        for word in words.keys {
            alertController.addAction(UIAlertAction(title: word, style: .default, handler: { [weak alertController] (_) in
                self.wordLabel.text = self.words[word]
            }))
        }
    }
    
    @IBAction func writeNewWord(_ sender: Any) {
        self.present(alertController, animated: true, completion: nil)
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


}

