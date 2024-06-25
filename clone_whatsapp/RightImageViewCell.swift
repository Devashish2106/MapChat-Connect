//
//  RightImageViewCell.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 24/06/24.
//

import UIKit

class RightImageViewCell: UITableViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var messageImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customContentView.layer.cornerRadius = 12
        
        customContentView.backgroundColor = UIColor(hexString: "E1F7CB")
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        
    }
    func configure(image : UIImage){
        messageImg.image = image
        messageImg.layer.cornerRadius = 12
    }

}
