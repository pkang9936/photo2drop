//
//  ScannerViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 1/12/16.
//  Copyright © 2016 Kang, Puthyrak. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: SWFrontViewController, AVCaptureMetadataOutputObjectsDelegate {
    var session: AVCaptureSession!
    var theCamera: AVCaptureDevice!
    var theInputSource: AVCaptureDeviceInput!
    var theOutputSource: AVCaptureMetadataOutput!
    var thePreview: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for theItem in metadataObjects {
            if let _item = theItem as? AVMetadataMachineReadableCodeObject {
                print("We read\(_item.stringValue) from a barcode of type: \(_item.type)")
            }
        }
    }
    @IBAction func doScanBarCode(sender: AnyObject) {
        let allCameras = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        for camera in allCameras {
            if camera.position == AVCaptureDevicePosition.Back {
                theCamera = camera as! AVCaptureDevice
                break
            }
        }
        session = AVCaptureSession()
        if theCamera != nil {
            do {
                try theInputSource = AVCaptureDeviceInput(device: theCamera)
                
            }catch _ as NSError {
                NSLog("Error")
            }
            if session.canAddInput(theInputSource){
                session.addInput(theInputSource)
            }
            
            theOutputSource = AVCaptureMetadataOutput()
            if session.canAddOutput(theOutputSource) {
                session.addOutput(theOutputSource)
            }
            let options = [AVMetadataObjectTypeQRCode,
                AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code
            ]
            
            theOutputSource.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            theOutputSource.metadataObjectTypes = options
            
            thePreview = AVCaptureVideoPreviewLayer(session: session)
            self.view.layer.addSublayer(thePreview)
            thePreview.frame = self.view.bounds
            thePreview.videoGravity = AVLayerVideoGravityResizeAspectFill
            
        }
        session.startRunning()

    }
    
}













