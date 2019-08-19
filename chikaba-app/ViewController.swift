//
//  ViewController.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/19.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit
import Alamofire

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

    @IBOutlet weak var TableView: UITableView!
    @IBAction func JumpSearchScreen(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        // データの取得
//        _ = requestFirst()
        
//        getRecomendation()
        
//        getStoreList()
        
        getImage()
        
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
}

extension ViewController: UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell: LogoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "logo") as? LogoTableViewCell {
                return cell
            }
            return UITableViewCell()
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else {
            return 100
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
