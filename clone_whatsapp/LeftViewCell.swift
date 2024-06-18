//
//  LeftViewCell.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 17/06/24.
//

import UIKit

class LeftViewCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.layer.cornerRadius = 12
        messageContainerView.backgroundColor = .white
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func configureCell(message: Message) {
        textMessageLabel.text = message.text
    }
    
}
