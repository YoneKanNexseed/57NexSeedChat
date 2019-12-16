//
//  SearchViewController.swift
//  NexSeedChat
//
//  Created by yonekan on 2019/12/16.
//  Copyright © 2019 yonekan. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    // 検索結果の部屋情報一覧を入れる変数
    var rooms: [Room] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // 検索ボタンがクリックされた時の処理
    @IBAction func didClickSearchButton(_ sender: UIButton) {
        
        // Firestoreに接続
        let db = Firestore.firestore()
        
        // データを取得する
//        db.collection("rooms")
//            .whereField("name", isEqualTo: textField.text!)
//            .getDocuments { (querySnapShot, error) in
//
//            guard let docs = querySnapShot?.documents else {
//                return
//            }
//
//            var results: [Room] = []
//
//            for doc in docs {
//                let id = doc.documentID
//                let name = doc.get("name") as! String
//
//                let room = Room(documentId: id, name: name)
//                results.append(room)
//            }
//
//            self.rooms = results
//
//        }
        
        // 前方一致でデータを取得する
        db
            .collection("rooms")
            .order(by: "name")
            .start(at: [textField.text!])
            .end(at: [textField.text! + "{f8ff}"])
            .getDocuments { (querySnapShot, error) in
            guard let docs = querySnapShot?.documents else {
                return
            }

            var results: [Room] = []

            for doc in docs {
                let id = doc.documentID
                let name = doc.get("name") as! String

                let room = Room(documentId: id, name: name)
                results.append(room)
            }

            self.rooms = results
        }
        
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rooms.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let room = rooms[indexPath.row]
        
        cell.textLabel?.text = room.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // クリックされた部屋情報を取得
        let room = rooms[indexPath.row]
        
        // 画面遷移実行
        performSegue(withIdentifier: "toChat", sender: room.documentId)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChat" {
            let chatVC = segue.destination as! ChatViewController
            chatVC.documentId = sender as! String
        }
    }
    
}
