//
//  TagsViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/22/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase

class TagsViewController: UIViewController {

    @IBOutlet var tagLabels: [UILabel]!
    var tags: [String?] = []
    var user: User?
    var dataRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var count = 0
        
    
        DispatchQueue.main.async {
            for tagLabel in self.tagLabels {
                guard let tag = self.tags[count] else {
                    break
                }
                
                tagLabel.text = tag
                count += 1
            }
            print(self.user?.username)
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        print("hi")
        
    }

    @IBAction func onFinish(_ sender: Any) {
        let currentUid = (FIRAuth.auth()?.currentUser?.uid)!
        let currUser = dataRef.child("users").child(currentUid)
        let user2 = dataRef.child("users").child((user?.uid)!)

        let game = dataRef.child("games").childByAutoId()
        var info: [String: Any] = ["user1": currentUid]
        info["user2"] = (user?.uid)!
        info["current"] = 1
        game.setValue(info)
        
        
        
        currUser.child("games").childByAutoId().setValue(game.key)
        user2.child("games").childByAutoId().setValue(game.key)
        
        print(info)
        performSegue(withIdentifier: "finishSegue", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}
