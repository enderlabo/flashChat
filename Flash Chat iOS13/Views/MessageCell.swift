//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Laborit on 28/06/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImgAvatar: UIImageView!
    @IBOutlet weak var letImgAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        messageBubble.layer.shadowColor = UIColor.systemRed.cgColor
        messageBubble.layer.shadowOpacity = 0.5
        messageBubble.layer.shadowOffset = .zero
        messageBubble.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
