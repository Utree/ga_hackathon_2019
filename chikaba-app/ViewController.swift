//
//  ViewController.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/19.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
//{
//    "name": "テスト店40",
//    "discription": "説明文がここに入ります",
//    "main_image_path": "/img/thumbnail/40.png",
//    "place": "六本木一丁目駅から徒歩5分",
//    "thumbnail_path": "/img/thumbnail/40.png",
//    "webpage": "https://hoge.com/fuga",
//    "latitude": "35.6655448",
//    "longitude": "139.7367123",
//    "price_id": 6,
//    "vacant_id": 3,
//    "category_id": 2,
//    "created_at": "2019-08-20T03:44:03.865Z",
//    "updated_at": "2019-08-20T03:44:03.865Z",
//    "price": {
//        "id": 6,
//        "name": "¥5,000〜¥10,000",
//        "value": 5,
//        "created_at": "2019-08-20T03:44:03.529Z",
//        "updated_at": "2019-08-20T03:44:03.529Z"
//    },
//    "vacant": {
//        "id": 3,
//        "name": "many",
//        "value": 2,
//        "created_at": "2019-08-20T03:44:03.554Z",
//        "updated_at": "2019-08-20T03:44:03.554Z"
//    }
//},

struct Item: Codable {
    let price_id: Int
    let vacant_id: Int
    let category_id: Int
    
    let name: String
    let discription: String
    let main_image_path: String
    let place: String
    let thumbnail_path: String
    let webpage: String
    let latitude: String
    let longitude: String
    
    let price: Price
    let vacant: Vacant
    let category: Category
    
    let created_at: String
    let updated_at: String
    
    struct Price: Codable {
        let id: Int
        let name: String
        let value: Int
        let created_at: String
        let updated_at: String
    }
    struct Vacant: Codable {
        let id: Int
        let name: String
        let value: Int
        let created_at: String
        let updated_at: String
    }
    struct Category: Codable {
        let id: Int
        let name: String
        let created_at: String
        let updated_at: String
    }
    
}

class ViewController: UIViewController {
    //    tableViewのインスタンス
    @IBOutlet weak var TableView: UITableView!
    //    locationManagerのインスタンス
    var locationManager: CLLocationManager!
    //    データ
    var shops:[ItemViewModel] = [ItemViewModel]()
    var currentLongitude = 0.0
    var currentLatitude = 0.0
    
    var items:[Item] = [Item]()
    
    var selectedItemIndex = 0

//    検索ボタン押下
    @IBAction func JumpSearchScreen(_ sender: Any) {
        print("検索ボタン押下")
        self.performSegue(withIdentifier: "toSearch", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        //        TableViewにxibを登録
        TableView.register(UINib(nibName: "ShopTableViewCell", bundle: nil), forCellReuseIdentifier: "shop")
        
//        位置情報取得
        setupLocationManager()
        
//        おすすめ一覧を表示
        getRecomendation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        セルの選択解除
        if let indexPathForSelectedRow = TableView.indexPathForSelectedRow {
            TableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    func setupData(data: [Item]) {
        if data.isEmpty {
            //        データを初期化
            shops = [ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!, vacant: "few"), ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!, vacant: "few"), ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!, vacant: "few")]
        } else {
            shops = [ItemViewModel]()
            //        データを整形
            for d in data {
                shops.append(ItemViewModel(name: d.name, category: d.category.name, distance: d.place, priceRange: d.price.name, thumbnail: URL(string: d.thumbnail_path)!, vacant: d.vacant.name)
                             )
            }
        }
        
        // データを更新
        TableView.reloadData()
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
        Alamofire.request("https://api.myjson.com/bins/ksfuz").response { response in
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
    
    private func getRecomendation() {
        let parameters: Parameters = [
            "type": "recomendation",
            "latitude": self.currentLatitude,
            "longitude": self.currentLongitude
        ]
        
        Alamofire.request("https://chikaba.herokuapp.com/api/stores", method: .get, parameters: parameters)
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
        
//        returnMockUpData()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        self.currentLatitude = location?.coordinate.latitude ?? 35.7020691
        self.currentLongitude = location?.coordinate.longitude ?? 139.7753269
    }
}

extension ViewController: UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return shops.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "logo") as! LogoTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "shop") as! ShopTableViewCell
            
            // アイテムを追加
            cell.setupCell(with: shops[indexPath.row])
    
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたshopセクションのセルの行番号を出力
        if(indexPath.section == 1) {
            print("\(indexPath.row)番目の行が選択されました。")
            
            selectedItemIndex = indexPath.row
            
            self.performSegue(withIdentifier: "toShopInfomation", sender: nil)
        }
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
            nextView.descrip = items[selectedItemIndex].discription
        }
    }

}
