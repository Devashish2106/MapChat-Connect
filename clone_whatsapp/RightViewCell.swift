//
//  RightViewCell.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 17/06/24.
//

import UIKit

class RightViewCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.layer.cornerRadius = 12
        messageContainerView.backgroundColor = UIColor(hexString: "E1F7CB")
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func configureCell(message: Message) {
        textMessageLabel.text = message.text
    }
}

extension UIColor {
    convenience init(hexString: String) {
        var hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hex.count == 3 {
            let r = hex.index(hex.startIndex, offsetBy: 1)
            let g = hex.index(hex.startIndex, offsetBy: 2)
            let b = hex.index(hex.startIndex, offsetBy: 3)
            hex = "\(hex[hex.startIndex])\(hex[hex.startIndex])\(hex[r])\(hex[r])\(hex[g])\(hex[g])\(hex[b])\(hex[b])"
        }
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

