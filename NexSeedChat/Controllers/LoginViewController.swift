//
//  LoginViewController.swift
//  NexSeedChat
//
//  Created by yonekan on 2019/12/10.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import RevealingSplashView

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

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
            // スプラッシュを表示したので、「true:表示したと設定」
            didDisplaySplashFlg = true
        }
    }    

}

// LoginViewControllerをGoogle Loginできるよう拡張
extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // エラーがないかチェック
        if let err = error {
            // 変数errorがnilでない場合
            // エラー情報を出力
            print(err.localizedDescription)
            
            return // 処理中断
        }
        
        // 認証情報を取得
        guard let authentication = user.authentication else {
            // 認証情報がなければ、処理を中断
            return
        }
        
        // Firebaseに認証情報を登録
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            
            if let err = error {
                // エラーがある場合
                print(err.localizedDescription)
            } else {
                // エラーがない場合
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
            
        }
    }
    
}
