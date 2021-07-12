//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    //Dictionary of messages
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = Constant.appName
        tableView.dataSource = self
       //using UINib, this are extras element on UI ( cell of chat, cards, etc).
        tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        
        loadMessages()

    }
    
    func loadMessages(){
        
        //with addSnapshotListener can hear the change insisde this collection and order by.
        db.collection(Constant.FStore.collectionName).order(by: Constant.FStore.dateField).addSnapshotListener { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    for doc in snapShotDocuments {
                        //doc.data are the data from fireStore by the user logged.
                        let data = doc.data()
                        //data[Constant.FStore.senderField] and data[Constant.FStore.bodyField] is the data saved on fireStore.
                      if  let msgSender = data[Constant.FStore.senderField] as? String, let msgBody = data[Constant.FStore.bodyField] as? String {
                            let newMessage = Message(message: msgSender, body: msgBody)
                        //add messages from fireStore to dictionary and showes in UI when user is logged in.
                            self.messages.append(newMessage)
                        // show the data on UI
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                //add funcionality when get a new message, go to scroll down
                                let indexPath = IndexPath(row: self.messages.count - 1, section:   0  )
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                //when send a message, clean the input with empty string.
                                self.messageTextfield.text = ""
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        //if messageBody isn't empty and user is logged, then send message to fireStore.
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constant.FStore.collectionName).addDocument(data: [ Constant.FStore.senderField: messageSender, Constant.FStore.bodyField: messageBody, Constant.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
           if let e = error {
                print("There was an issue saving data to fireStore: \(e)")
            } else {
                print("Successfully save data to FireStore.")
                }
            }
        }
    }
    
    @IBAction func LogOutPress(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
           //Back or navigate to initial screen.
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //show item in UITableView
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        //added UINib on tableView created before.
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as! MessageCell
        //show messages data on TableView
        cell.label.text = message.body
        //This is a message from the current user.
        if message.message == Auth.auth().currentUser?.email {
            cell.letImgAvatar.isHidden = true
            cell.rightImgAvatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constant.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constant.BrandColors.purple)
        }else {
            //This a message from another sender
            cell.letImgAvatar.isHidden = false
            cell.rightImgAvatar.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constant.BrandColors.purple)
            cell.label.textColor = UIColor(named: Constant.BrandColors.lightPurple)
        }
        
        
       
        
        
        
        return cell
    }
    
}
