//
//  QRScannerViewController.swift
//  Cooking
//
//  Created by kacalek on 12/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

//
//  QRScannerController.swift
//  todo-app
//
//  Created by kacalek on 07/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

import AVFoundation

class QRScannerViewController: UIViewController {
    
    @IBOutlet weak var photoButton: UIButton!
    @IBAction func photoBtnClick(_ sender: Any) {
        print(code)
        self.performSegue(withIdentifier: "camera_scan", sender: nil)
    }
    
    var code: String = "" {
        didSet {
            if self.code == "" {
                photoButton.isHidden = true
            }else {
                messageLabel.text = self.code
                photoButton.isHidden = false
                view.bringSubview(toFront: photoButton)
            }
        }
    }
    @IBOutlet var messageLabel:UILabel!
    
    var captureSession = AVCaptureSession()
    
    @IBAction func flashBtnClick(_ sender: Any) {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if let device = device {
            if device.hasTorch {
                do{
                    try device.lockForConfiguration()
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                    return
                }
                device.torchMode = !device.isTorchActive ? AVCaptureDevice.TorchMode.on : AVCaptureDevice.TorchMode.off
                device.unlockForConfiguration()
            }
        }
    }
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    private let supportedCodeTypes = [
        AVMetadataObject.ObjectType.upce,
        AVMetadataObject.ObjectType.code39,
        AVMetadataObject.ObjectType.code39Mod43,
        AVMetadataObject.ObjectType.code93,
        AVMetadataObject.ObjectType.code128,
        AVMetadataObject.ObjectType.ean8,
        AVMetadataObject.ObjectType.ean13,
        AVMetadataObject.ObjectType.aztec,
        AVMetadataObject.ObjectType.pdf417,
        AVMetadataObject.ObjectType.itf14,
        AVMetadataObject.ObjectType.dataMatrix,
        AVMetadataObject.ObjectType.interleaved2of5,
        AVMetadataObject.ObjectType.qr
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        view.bringSubview(toFront: messageLabel)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
        
        let swipeFromRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
        swipeFromRight.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeFromRight)
    }
    
    @objc func didSwipeUp(gesture: UIGestureRecognizer) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier as Any)
        if segue.identifier == "camera_scan" {
            let cameraScan = segue.destination as! CameraScanViewController
            cameraScan.code = self.code
        }
    }
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if let code = metadataObj.stringValue{
//                if(code != self.code) {
//                }
                
                self.code = code
                self.performSegue(withIdentifier: "camera_scan", sender: nil)
            }
        }
    }
}

