//
//  Message.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 18/06/24.
//

import Foundation
import UIKit

enum MessageSide {
    case left
    case right
    case rightImage
    case leftImage
}

struct Message {
    var text = ""
    var side: MessageSide = .right
    var img: Bool = false
    var loc: UIImage = UIImage(named: "image_blank")!
}

