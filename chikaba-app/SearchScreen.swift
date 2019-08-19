//
//  SearchScreen.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/19.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit

class SearchScreen: UIViewController {
//    tableViewのインスタンス
    @IBOutlet weak var searchResultTable: UITableView!
//    pickerViewのインスタンス
    @IBOutlet weak var sortCategory: UIPickerView!
//    検索ボタン押下処理
    @IBAction func searchButton(_ sender: Any) {
//        pickerViewの値を取得
        print("\(list[sortCategory.selectedRow(inComponent: 0)])")
        
    }
//    １つ前の画面に戻る
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //    TableViewのデータ
    var shops:[ItemViewModel] = [ItemViewModel]()
//    pickerViewのデータ
    let list: [String] =  ["距離","値段","空席"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        delegate and datasource for tableview
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        
//        delegate and datasource for pickerView
        sortCategory.delegate = self
        sortCategory.dataSource = self
        sortCategory.showsSelectionIndicator = true
        
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

extension SearchScreen: UIPickerViewDelegate, UIPickerViewDataSource {
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        /*
         列が複数ある場合は
         if component == 0 {
         } else {
         ...
         }
         こんな感じで分岐が可能
         */
        return list.count
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        /*
         列が複数ある場合は
         if component == 0 {
         } else {
         ...
         }
         こんな感じで分岐が可能
         */
        return list[row]
    }
    
    /*
     // ドラムロール選択時
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     self.textField.text = list[row]
     }
     */
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

