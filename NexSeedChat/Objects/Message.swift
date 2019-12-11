//
//  Message.swift
//  NexSeedChat
//
//  Created by yonekan on 2019/12/11.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    
    // メッセージの本文
    let text: String
    
    // 送信者の情報
    var sender: SenderType
    
    // メッセージ固有のID
    var messageId: String
    
    // 送信日時
    var sentDate: Date
    
    // メッセージの種類
    var kind: MessageKind {
        return .text(text)
    }
    
}
