//
//  ShopTableViewCell.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/19.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var prices: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
