//
//  User.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/22/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase

class User: NSObject {
    let username: String!
    let uid: String!

    init(userInfo: FIRDataSnapshot) {
        username = userInfo.value! as! String
        uid = userInfo.key
        
    }
}
