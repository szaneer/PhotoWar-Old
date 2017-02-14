
//
//  FireViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/22/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import RapidAPISDK
import SwiftyJSON
import M13ProgressSuite

class FireViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var sendButton: UIButton!
    var tags: [String] = []
    var progress: M13ProgressHUD!
    
    @IBOutlet weak var attackView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        progress = M13ProgressHUD(progressView: M13ProgressViewRing.init())
        progress.progressViewSize = CGSize(width: 60.0, height: 60.0)
        progress.animationPoint = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        
        self.view.addSubview(progress)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func loadTags(image: Data) {
        print("hi")
        //print(image)
//        let parameters = [
//            "subscriptionKey": "5bea5ab175934b5985ab3a3ecc083702",
//            "image": image] as [String : Any]
//        let test = RapidConnect(projectName: "BoilerMake", andToken: "b8694d62-c8f8-4f95-aa7c-c40049e5e3d8")
//        test?.callPackage("MicrosoftComputerVision", block: "tagImage", withParameters: parameters, success: { (info) in
//            //print(info)
//            let json = info!["payload"] as! String
//            
//            let payload = JSON.parse(json)
//            let tags = payload["tags"].arrayValue
//            
//            
//            for tag in tags {
//                print(tag)
//                self.tags.append(tag["name"].stringValue)
//            }
//            
//            self.sendButton.isHidden = false
//        }, failure: { (error) in
//            print(error?.localizedDescription)
//        })
        progress.setProgress(0.25, animated: true)
        let parameters = [
            "clientId": "x6YUmBDXYxb0XN1PbFdV89b0_gLWMo0eQ7JP6bKP", "clientSecret" : "_whYkPM5vmmhVM84srPjBeieOTvFhUf5pxTRjlGy", "image": image] as [String : Any]
        
        let analyzer = RapidConnect(projectName: "BoilerMake", andToken: "b8694d62-c8f8-4f95-aa7c-c40049e5e3d8")
        
        analyzer?.callPackage("ClarifaiPublicModels", block: "analyzeImageGeneral", withParameters: parameters, success: { (info) in
            //print(info!["payload"])
            self.progress.setProgress(0.50, animated: true)
            let payload = info!["payload"] as! [AnyHashable: Any]
            let outputs = payload["outputs"] as! NSArray
            let concepts = JSON(outputs[0])
            let data = concepts["data"]["concepts"].array
            for x in 0...5 {
                guard let tag = data?[x] else {
                    break
                }
                self.tags.append(tag["name"].stringValue)
            }
            self.progress.setProgress(0.75, animated: true)
            print(self.tags)
            self.sendButton.isHidden = false
            self.progress.setProgress(1, animated: true)
            self.progress.dismiss(true)
        }, failure: { (error) in
            guard let error = error else {
                return
            }
            self.progress.dismiss(true)
            print(error.localizedDescription)
        })
    }

    @IBAction func onFire(_ sender: Any) {
        let photoController = UIImagePickerController()
        
        photoController.delegate = self
        photoController.allowsEditing = true
        photoController.sourceType = .camera
        
        self.present(photoController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            let data = UIImageJPEGRepresentation(image, 0.8)
            attackView.image = image
            sendButton.isHidden = true
            progress.setProgress(0, animated: true)
            progress.show(true)
            progress.applyBlurToBackground = true
            loadTags(image: data!)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSend(_ sender: Any) {
        performSegue(withIdentifier: "sendSegue", sender: nil)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! TagsViewController
        print(self.tags)
        vc.tags = self.tags
    }
    

}
