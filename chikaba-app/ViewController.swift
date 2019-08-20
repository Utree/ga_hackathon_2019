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


struct Item: Codable {
    let id: Int
    let prices_id: Int
    let vacants_id: Int
    let name: String
    let category: String
    let discription: String
    let main_image_path: String
    let place: String
    let thumbnail_path: String
    let webpage: String
    let latitude: Float
    let longitude: Float
    let price: Price
    let vacant: Vacant
    
    struct Price: Codable {
        let id: Int
        let name: String
    }
    struct Vacant: Codable {
        let id: Int
        let name: String
    }
}

class ViewController: UIViewController {
    //    tableViewのインスタンス
    @IBOutlet weak var TableView: UITableView!
    //    locationManagerのインスタンス
    var locationManager: CLLocationManager!
    //    データ
    var shops:[ItemViewModel] = [ItemViewModel]()

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
        self.setupData();

        // データの取得
//        _ = requestFirst()
        
//        getRecomendation()
        
//        getStoreList()
        
        getImage()
        
        setupLocationManager()
        
        //        初期化
        setupData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        セルの選択解除
        if let indexPathForSelectedRow = TableView.indexPathForSelectedRow {
            TableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    func setupData() {
        //        データを初期化
        shops = [ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!),ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!),ItemViewModel(name: "test", category: "test", distance: "test", priceRange: "test", thumbnail: URL(string: "https://httpbin.org/image/png")!)]
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
    
    private func requestFirst() -> [Item]? {
        var result: [Item]? = nil
        
//        リクエスト
        Alamofire.request("https://api.myjson.com/bins/19ho7f").response { response in
            let decoder = JSONDecoder()
            
            guard let data = response.data else { return }
//            Jsonのパース
            do {
                result = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
        }
        return result
    }
    
    private func getRecomendation() {
        let parameters: Parameters = [
            "type": "recomendation",
            "latitude": 0,
            "longitude": 0
            
        ]
        
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }
    
    private func getStoreList() {
        let parameters: Parameters = [
            "type": "search",
            "latitude": 0,
            "longitude": 0,
            "filter": [
                "destination": "null",
                "vacant": "空　中　混",
                "price": "500円以上1000未満",
                "category": "中華"
            ]
        ]
        
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { response in
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
        }
    }
    
    //    画像の表示
    private func getImage() {
        let url = "https://httpbin.org/image/png"
        
        let dest:DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("pig.png")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url, to: dest)
            .responseData { [weak self](res) in
                guard let myself = self else { return }
                
                if let data = res.result.value {
                    let image = UIImage(data: data)
                    //                    myself.pictureImageView.image = image //表示される
                }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        print("locationManager called")
        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
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
        self.performSegue(withIdentifier: "toShopInfomation", sender: nil)
        // タップされたshopセクションのセルの行番号を出力
        if(indexPath.section == 1) {
            print("\(indexPath.row)番目の行が選択されました。")
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // ②Segueの識別子確認
        if segue.identifier == "toShopInfomation" {
            
            // ③遷移先ViewCntrollerの取得
            let nextView = segue.destination as! ShopInfomation
        
            // ④値の設定
            nextView.Name = "asasa"
            nextView.imagePath = "https://bankkita.com/images/mexican-food-png-3.png"
            nextView.url = "http://localhost/shop/webpage/"
        }
    }

}
