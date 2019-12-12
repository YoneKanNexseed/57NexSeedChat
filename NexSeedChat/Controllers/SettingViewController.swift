//
//  SettingViewController.swift
//  NexSeedChat
//
//  Created by yonekan on 2019/12/12.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 現在ログインしている人を取得
        let user = Auth.auth().currentUser!
        
        nameLabel.text = user.displayName
        emailLabel.text = user.email
        
        // URLを元に画像データを取得
        let data = try! Data(contentsOf: user.photoURL!)
        
        // 取得したデータを元に、Imageを作成
        let image = UIImage(data: data)
        
        imageView.image = image
    }

    // ログアウトボタンがクリックされた時の処理
    @IBAction func didClickLogoutButton(_ sender: UIButton) {
        
        try! Auth.auth().signOut()
        
    }
    
    
}
