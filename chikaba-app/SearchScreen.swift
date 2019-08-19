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
    
}
    extension SearchScreen: UITableViewDelegate ,UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 || section == 1 {
                return 1
            } else {
                return 10
            }
        }
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "search") as! LogoTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "shop") as! ShopTableViewCell
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 || indexPath.section == 1{
                return 150
            }
           if indexPath.section == 2{
                return 200
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            // タップされたshopセクションのセルの行番号を出力
            if(indexPath.section == 1) {
                print("\(indexPath.row)番目の行が選択されました。")
            }
        }
    }

