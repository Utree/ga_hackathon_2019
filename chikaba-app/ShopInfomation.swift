//
//  ShopInfomation.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/20.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit

class ShopInfomation: UIViewController {

    var Name = ""
    var Image = ""
    var url = ""
    @IBOutlet weak var shopImage: UIImageView!
    
    @IBOutlet weak var shopName: UILabel!
   
    @IBOutlet weak var URL: UIButton!
    
   
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        shopName.text = Name
        URL.setTitle(url, for: .normal)
    }
    
}
