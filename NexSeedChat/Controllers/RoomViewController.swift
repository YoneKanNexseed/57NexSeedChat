//
//  RoomViewController.swift
//  NexSeedChat
//
//  Created by yonekan on 2019/12/10.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
import Firebase
import RevealingSplashView

class RoomViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    // テーブルに表示する全データを持つ配列
    var rooms: [Room] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        showSpalshView()
        
        // Firestoreに接続
        let db = Firestore.firestore()
        
        // roomsコレクションを監視
        db.collection("rooms").addSnapshotListener {
            (querySnapShot, error) in
            
            guard let documents = querySnapShot?.documents else {
                // ドキュメントがnilの場合、処理を中断
                return
            }
            
            var results: [Room] = []
            
            for document in documents {
                let name = document.get("name") as! String
                let id = document.documentID
                let room = Room(documentId: id, name: name)
                results.append(room)
            }
            
            self.rooms = results
        }
    }

    // 追加ボタンが押された時の処理
    @IBAction func didClickButton(_ sender: UIButton) {
        
        // 名前が空文字かチェック
        if textField.text!.isEmpty {
            // 空文字の場合
            return // 処理を中断
        }
        
        // Firestoreに接続
        let db = Firestore.firestore()
        
        // roomsコレクションに、新しいドキュメントを追加
        db.collection("rooms").addDocument(data: [
            "name": textField.text!,
            "createdAt": FieldValue.serverTimestamp()
        ]) {error in
            if let err = error {
                // エラーがある場合
                print(err.localizedDescription)
            }
        }
        
        // テキストフィールドを空にする
        textField.text = ""
    }
    
    // スプラッシュ画面を表示するメソッド
    func showSpalshView() {
        
        // スプラッシュ画面の作成
        let splashView = RevealingSplashView(
            iconImage: UIImage(named: "seedkun")!,
            iconInitialSize: CGSize(width: 250, height: 250),
            backgroundColor:
            UIColor(red: 79/255, green: 171/255, blue: 255/255, alpha: 1))
        
        // スプラッシュのアニメーション設定
        splashView.animationType = .swingAndZoomOut
        // 画面に表示
        self.tabBarController?.view.addSubview(splashView)
        // アニメーション開始
        splashView.startAnimation {
            // アニメーション終了時の処理
        }
        
    }
    
}


extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rooms.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let room = rooms[indexPath.row]
        
        cell.textLabel?.text = room.name
        
        return cell
    }
    
}
