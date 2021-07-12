//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        //hidden the navigationBar on WelcomeScreen.
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //this method is usefull, only disappear navigationBar in Welcome and another view keep the navigationBar with this.
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = Constant.appName

//        titleLabel.text = ""
//        var charIndex = 0.0
//        let titleText = "⚡️FlashChat"
//        for letter in titleText{
//            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false){ timer in
//                self.titleLabel.text?.append(letter)
//            }
//            charIndex += 1
//        }
       
    }
    

}
