//
//  AppDelegate.swift
//  HelloWolrd
//
//  Created by taohanyao on 17/3/31.
//  Copyright © 2017年 taohanyao. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
var transfer:Bool = false
var changeSt:Bool = false
var patientID = 0

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
   
    @IBOutlet weak var messageLabel:UILabel!
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var wait:Bool = false
        
    // Added to support different barcodes
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Scan"

        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)

            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession?.addInput(input)

            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

            // Detect all the supported bar code
            captureMetadataOutput.metadataObjectTypes = supportedBarCodes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture
            captureSession?.startRunning()
            
            // Move the message label to the top view
            view.bringSubview(toFront: messageLabel)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No barcode/QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Here we use filter method to check if the type of metadataObj is supported
        // Instead of hardcoding the AVMetadataObjectTypeQRCode, we check if the type
        // can be found in the array of supported bar codes.
        if supportedBarCodes.contains(metadataObj.type) {
//        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
             print("transfer:")
            print(transfer)
            print("changeSt:")
            print(changeSt)
            print("wait:")
            print(wait)
            if  transfer
            {
                return
            }
            if  changeSt
            {
                return
            }
            if wait
            {
                return
            }
            if metadataObj.stringValue != nil  {
                messageLabel.text = metadataObj.stringValue
                if (Int(metadataObj.stringValue) != nil)
                {
                    patientID = Int(metadataObj.stringValue)!
                    wait = true
                    getSwabStates()
                    
                }
                messageLabel.text = "QR code is not valid"
                let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    return
                }
                
            }
            
            
            
        }
    }
    func getSwabStates() {
        var parameters: Parameters = [
            "patient_id": patientID
        ]
        let headers: HTTPHeaders = [
            "Authorization": apiKey!
        ]
        
        
        Alamofire.request(ipAddress + "swabPatient", method: .post, parameters: parameters, headers:headers)
            .responseJSON { response in
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    let t_swab = JSON["t_swab"] as? String
                    
                    parameters = [
                        "t_swab": Int(t_swab!)!
                    ]
                    
                    Alamofire.request(ipAddress + "currentSwabStatus", method: .post, parameters: parameters, headers:headers)
                        .responseJSON { response in
                            //to get status code
                            if let status = response.response?.statusCode {
                                switch(status){
                                case 201:
                                    print("example success")
                                default:
                                    print("error with response status: \(status)")
                                }
                            }
                            //to get JSON return value
                            if let result = response.result.value {
                                let JSON = result as! NSDictionary
                                let status = JSON["status"] as? String
                                
                                if status == "sending" {
                                    self.wait = false
                                    self.performSegue(withIdentifier: "toChangeStatus", sender:nil)
                                    changeSt = true
                                }
                                else if status == "damaged" {
                                    self.wait = false
                                    let msg = "The swab is damaged!"
                                    let alert = UIAlertController(title: "Damageds", message: msg,preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { Void in
                                        self.dismiss(animated: false, completion: nil)
                                        self.navigationController?.popViewController(animated: true)
                                    }))
                                    
                                    self.present(alert, animated: true)
                                    print("damaged")
                                }
                                else if status == "received" {
                                    self.wait = false
                                    self.performSegue(withIdentifier: "Inquire", sender:nil)
                                    transfer = true
                                }

                                
                            }
                    }
                    
                    ///
                    
                    
                }
        }
        
        

    }

    func getpatientinfo(_ patientID:String)  {
       self.performSegue(withIdentifier: "Inquire", sender:nil)
        
    }
    
    
}

