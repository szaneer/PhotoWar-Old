//
//  LoginViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/22/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let videoURL = Bundle.main.url(forResource: "main", withExtension: "MOV")
        player = AVPlayer(url: videoURL!)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        playerLayer.frame = view.frame
        view.layer.addSublayer(playerLayer)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        player?.play()
        
        //loop video
        NotificationCenter.default.addObserver(self,
                                                         selector: "loopVideo",
                                                         name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                         object: nil)
        // Do any additional setup after loading the view.
        view.isUserInteractionEnabled = true
        
        blurEffectView.isUserInteractionEnabled = true
        print(emailField.isUserInteractionEnabled)
        self.view.bringSubview(toFront: emailField)
        self.view.bringSubview(toFront: passwordField)
        self.view.bringSubview(toFront: registerButton)
        self.view.bringSubview(toFront: loginButton)
        self.view.bringSubview(toFront: nameLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty else {
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            print("hi")
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Signed in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        })
    }
    
    
    @IBAction func onRegister(_ sender: Any) {
        
    }

    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
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
