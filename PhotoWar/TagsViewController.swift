//
//  TagsViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/22/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class TagsViewController: UIViewController {

    @IBOutlet var tagLabels: [UILabel]!
    var tags: [String?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var count = 0
        for tagLabel in tagLabels {
            guard let tag = tags[0] else {
                break
            }
            
            tagLabel.text = tag
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
