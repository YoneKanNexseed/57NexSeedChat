//
//  SplashViewController.swift
//  NexSeedChat
//
//  Created by yonekan on 2019/12/09.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
import RevealingSplashView

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スプラッシュ画面の作成
        let splashView = RevealingSplashView(
            iconImage: UIImage(named: "seedkun")!,
            iconInitialSize: CGSize(width: 250, height: 250),
            backgroundColor:
            UIColor(red: 79/255, green: 171/255, blue: 255/255, alpha: 1))
        
        // スプラッシュのアニメーション設定
        splashView.animationType = .swingAndZoomOut
        // 画面に表示
        self.view.addSubview(splashView)
        // アニメーション開始
        splashView.startAnimation {
            // アニメーション終了時の処理
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }

}
