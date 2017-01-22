//
//  ViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/21/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

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
            print("hi")
            
        }
        picker.dismiss(animated: true, completion: nil)
    }

}

