//
//  RegisterViewController.swift
//  EndTerm
//
//  Created by Manav Sethi on 2019-12-04.
//  Copyright © 2019 Manav Sethi. All rights reserved.
//

import UIKit
import AVFoundation

class RegisterViewController: UIViewController {
    let session = AVCaptureSession()
    var camera: AVCaptureDevice?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var cameraCaptureOutput: AVCapturePhotoOutput?

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func takePhoto(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func displayCapturedPhoto(capturedPhoto: UIImage){
            imageView.image = capturedPhoto
        }
        
        func initializeCaptureSession(){
            session.sessionPreset = AVCaptureSession.Preset.high
            camera = AVCaptureDevice.default(for: AVMediaType.video)
            do {
                let cameraCaptureInput = try AVCaptureDeviceInput(device: camera!)
                cameraCaptureOutput = AVCapturePhotoOutput()
                session.addInput(cameraCaptureInput)
                session.addOutput(cameraCaptureOutput!)
            } catch {
                print(error.localizedDescription)
            }
            cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            cameraPreviewLayer?.frame = view.bounds
            cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
            session.startRunning()
        }

        func takePicture(){
            let settings = AVCapturePhotoSettings()
            cameraCaptureOutput?.capturePhoto(with: settings, delegate: self)
        }
    }

    extension RegisterViewController: AVCapturePhotoCaptureDelegate {
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?){
            
            if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
            } else {
                if let sampleBuffer = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer){
                if let finalImage = UIImage(data: dataImage){
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                    secondViewController.image = finalImage
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
            }
            }
        }

}
