//
//  SearchScreen.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/19.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit

class SearchScreen: UIViewController {
    let sortList = ["カテゴリー","値段","空席"]
//    tableViewのインスタンス
    @IBOutlet weak var searchResultTable: UITableView!
//    データ
    var shops:[ItemViewModel] = [ItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        
        //        TableViewにxibを登録
        searchResultTable.register(UINib(nibName: "ShopTableViewCell", bundle: nil), forCellReuseIdentifier: "shop")
        self.setupData();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        セルの選択解除
        if let indexPathForSelectedRow = searchResultTable.indexPathForSelectedRow {
            searchResultTable.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    func setupData() {
        //        データを初期化
        shops = [ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!),ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!),ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!)]
    }
}
    extension SearchScreen: UITableViewDelegate ,UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return shops.count
        }
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shop") as! ShopTableViewCell
            
            cell.setupCell(with: shops[indexPath.row])
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            // タップされたshopセクションのセルの行番号を出力
            if(indexPath.section == 1) {
                print("\(indexPath.row)番目の行が選択されました。")
            }
        }
    }

