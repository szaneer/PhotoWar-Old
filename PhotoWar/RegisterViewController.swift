//
//  RegisterViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/22/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Photos
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var avatarView: UIImageView!
    
    var imageRef = FIRStorage.storage().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onUpload(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func onRegister(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty else {
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        guard let username = usernameField.text, !username.isEmpty else {
            return
        }
        guard let image = avatarView.image else {
            return
        }
        
        let data = UIImageJPEGRepresentation(image, 0.8)
        
        let photoRef = imageRef.child("avatars")
        
        let uuid = UUID().uuidString
        
        photoRef.child(uuid).put(data!, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(metadata?.downloadURL() ?? "")
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Succesfully registered \(user?.email)!")
                        let info = user?.profileChangeRequest()
                        
                        info?.photoURL = metadata?.downloadURL()!
                        
                        info?.displayName = username
                        
                        info?.commitChanges(completion: { (error) in
                            print(error?.localizedDescription)
                            if error == nil {
                                print((FIRAuth.auth()?.currentUser?.email)!)
                                let dataRef = FIRDatabase.database().reference().child("users")
                                
                                let usernameRef = dataRef.child((FIRAuth.auth()?.currentUser?.uid)!)
//
                                usernameRef.setValue(["username": username])
                                
                                
                                
                                
                                self.performSegue(withIdentifier: "registerSegue", sender: nil)
                            }
                        })
                        
                        
                    }
                    
                })
            }
        })
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            avatarView.image = image
            
        }
        picker.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
