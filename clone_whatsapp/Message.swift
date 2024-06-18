//
//  Message.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 18/06/24.
//

import Foundation

enum MessageSide {
    case left
    case right
}

struct Message {
    var text = ""
    var side: MessageSide = .right
}

