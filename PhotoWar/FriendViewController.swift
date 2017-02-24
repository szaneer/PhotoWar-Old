//
//  FriendViewController.swift
//  PhotoWar
//
//  Created by Siraj Zaneer on 1/24/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase

class FriendViewController: UITableViewController {
    
    var friends: [User] = []
    var friendMap: [String: String] = [:]
    var otherPeopele: [String] = []
    var post = 0
    
    let dataRef =  FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        dataRef.child("users").observe(FIRDataEventType.value, with: { (snapshot) in
            
            let user = snapshot.childSnapshot(forPath: (FIRAuth.auth()?.currentUser?.uid)!)
            
            let uName = user.childSnapshot(forPath: "username").value as! String
            
            self.friendMap[uName] = "hi"
            
            let friendlist = user.childSnapshot(forPath: "friends")
            
            
            guard let friends = friendlist.children.allObjects as? [FIRDataSnapshot]   else {
                
                print("no friends gg")
                return
            }
            
            for friend in friends {
                print(friend.value)
                let user = User(userInfo: friend)
                self.friends.append(user)
            }
            
            let users = snapshot.children.allObjects as! [FIRDataSnapshot]
            
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return otherPeopele.count
        }
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)

        // Configure the cell...
        if indexPath.section == 1 {
            cell.textLabel?.text = self.otherPeopele[indexPath.row]
        } else {
            cell.textLabel?.text = self.friends[indexPath.row].username
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Friends"
        }
        return "People"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "friendSegue" {
            let vc = segue.destination as! FireViewController
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let user = friends[(indexPath?.row)!]
            vc.user = user
        }
    }
    

}
