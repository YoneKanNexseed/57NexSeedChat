//
//  ChatUser.swift
//  NexSeedChat
//
//  Created by yonekan on 2019/12/11.
//  Copyright © 2019 yonekan. All rights reserved.
//

import Foundation
import MessageKit

struct ChatUser: SenderType {
    
    // ユーザーのID
    // FirebaseのAuthenticationのuidを今回は使う
    var senderId: String
    
    // 表示名
    var displayName: String
    
    // アイコン画像のURL
    let photoUrl: String
}
