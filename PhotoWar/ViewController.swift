//
//  ViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/21/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Photos
import RapidAPISDK
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loadTags(image: Data) {
        print("hi")
        print(image)
        let parameters = [
            "subscriptionKey": "5bea5ab175934b5985ab3a3ecc083702",
            "image": image] as [String : Any]
        let test = RapidConnect(projectName: "BoilerMake", andToken: "b8694d62-c8f8-4f95-aa7c-c40049e5e3d8")
        test?.callPackage("MicrosoftComputerVision", block: "tagImage", withParameters: parameters, success: { (info) in
            let infoJson = JSON(info)
            let payload = infoJson["payload"]
            let tags = payload.arrayValue
            for tag in tags {
                print(tag["name"])
            }
        }, failure: { (error) in
            print(error?.localizedDescription)
        })
    }

    /*
     callPackage:@"Twilio" block:@"sendSms" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:
     @"AC9dba4638180495eb4da6ffff918fce28", @"accountSid",
     @"7c9cc4cdfbd67f439f8d115e48a2bff7", @"accountToken",
     @"+18477448182", @"from",
     @"", @"messagingServiceSid",
     @"+16307090080", @"to",
     @"Hi", @"body",
     @"", @"statusCallback",
     @"", @"applicationSid",
     @"", @"maxPrice",
     @"", @"provideFeedback",
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPhoto(_ sender: Any) {
        let photoController = UIImagePickerController()
        
        photoController.delegate = self
        photoController.allowsEditing = true
        photoController.sourceType = .photoLibrary
        
        self.present(photoController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            let data = UIImageJPEGRepresentation(image, 0.8)
            loadTags(image: data!)
        }
        picker.dismiss(animated: true, completion: nil)
    }

}

