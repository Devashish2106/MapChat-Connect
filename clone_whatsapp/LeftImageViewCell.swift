//
//  LeftImageViewCell.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 25/06/24.
//

import UIKit

class LeftImageViewCell: UITableViewCell {

    @IBOutlet weak var msgImage: UIImageView!
    @IBOutlet weak var customContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customContentView.layer.cornerRadius = 12
        
        customContentView.backgroundColor = .white
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        
    }
    func configure(image : UIImage){
        msgImage.image = image
        msgImage.layer.cornerRadius = 12
    }

}
