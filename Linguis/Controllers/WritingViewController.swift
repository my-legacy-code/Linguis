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
    
    @IBOutlet weak var wordLabel: UITextField!
    @IBOutlet weak var cameraView: UIView!
    private lazy var cameraLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        guard
            let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let input = try? AVCaptureDeviceInput(device: backCamera)
            else { return session }
        session.addInput(input)
        return session
    }()
    
    var alertController: UIAlertController!
    var words: [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.cameraLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        // make the camera appear on the screen
        self.cameraView?.layer.addSublayer(self.cameraLayer)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
         self.captureSession.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.captureSession.stopRunning()
    }
    
    @IBAction func writeNewWord(_ sender: Any) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // make sure the layer is the correct size
        self.cameraLayer.frame = self.cameraView?.bounds ?? .zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

