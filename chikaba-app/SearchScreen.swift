//
//  SearchScreen.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/19.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class SearchScreen: UIViewController {
//    tableViewのインスタンス
    @IBOutlet weak var searchResultTable: UITableView!
//    pickerViewのインスタンス
    @IBOutlet weak var sortCategory: UIPickerView!
    //    locationManagerのインスタンス
    var locationManager: CLLocationManager!
    @IBOutlet weak var keyWordField: UITextField!
    
    //    検索ボタン押下処理
    @IBAction func searchButton(_ sender: Any) {
//        pickerViewの値を取得
        selectedOrder = list[sortCategory.selectedRow(inComponent: 0)]
//        keyWordFieldの値を取得
        keyWord = keyWordField.text ?? ""
        
        getStoreList()
    }
//    １つ前の画面に戻る
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //    TableViewのデータ
    var shops:[ItemViewModel] = [ItemViewModel]()
//    pickerViewのデータ
    let list: [String] =  ["距離","値段","空席"]
//    緯度経度
    var currentLongitude = 0.0
    var currentLatitude = 0.0
    var selectedOrder = "値段"
    var keyWord = "フレンチ"
    
    var items:[Item] = [Item]()
    var selectedItemIndex = 0
    
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
        
        //        位置情報取得
        setupLocationManager()
        
//        データを更新
        getStoreList();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        セルの選択解除
        if let indexPathForSelectedRow = searchResultTable.indexPathForSelectedRow {
            searchResultTable.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    func setupData(data: [Item]) {
        if data.isEmpty {
            //        データを初期化
            shops = [ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!, vacantID: 1), ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!, vacantID: 1), ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!, vacantID: 1)]
        } else {
            shops = [ItemViewModel]()
            //        データを整形
            for d in data {
                shops.append(ItemViewModel(name: d.name, category: d.category.name, distance: d.place, priceRange: d.price.name, thumbnail: URL(string: "https://www.google.com")!, vacantID: d.vacants_id))
            }
        }
        
        // データを更新
        searchResultTable.reloadData()
    }
    
    private func getStoreList() {
        let parameters: Parameters = [
            "type": "search",
            "latitude": currentLatitude,
            "longitude": currentLongitude,
            "field": selectedOrder,
            "order": "asc",
            "keyword": keyWord,
            ]
        
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                let decoder = JSONDecoder()
                
                guard let data = response.data else { return }
                //                Jsonのパース
                do {
                    self.items = try decoder.decode([Item].self, from: data)
                    self.setupData(data: self.items)
                } catch {
                    print(error)
                }
        }
        
        returnMockUpData()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        //　locationManagerの権限をviewControllerに渡す
        locationManager.delegate = self
        // アプリ利用時に位置情報を取得する
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    
    private func returnMockUpData(){
        //        リクエスト
        Alamofire.request("https://api.myjson.com/bins/gdm9n").response { response in
            let decoder = JSONDecoder()
            
            guard let data = response.data else { return }
            //            Jsonのパース
            do {
                self.items = try decoder.decode([Item].self, from: data)
                self.setupData(data: self.items)
            } catch {
                print(error)
            }
        }
    }
}

//ロケーションのデレゲート
extension SearchScreen: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        self.currentLatitude = location?.coordinate.latitude ?? 35.7020691
        self.currentLongitude = location?.coordinate.longitude ?? 139.7753269
    }
}

//ドラムロールのデレゲート
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

//テーブルビューのデレゲート
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
        
        self.performSegue(withIdentifier: "toShopInfomation", sender: nil)
        // タップされたshopセクションのセルの行番号を出力
        if(indexPath.section == 1) {
            print("\(indexPath.row)番目の行が選択されました。")
            
        }
        selectedItemIndex = indexPath.row
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // ②Segueの識別子確認
        if segue.identifier == "toShopInfomation" {
            
            // ③遷移先ViewCntrollerの取得
            let nextView = segue.destination as! ShopInfomation
            
            // ④値の設定
            nextView.Name = items[selectedItemIndex].name
            nextView.imagePath = items[selectedItemIndex].main_image_path
            nextView.url = items[selectedItemIndex].webpage
        }
    }
}

