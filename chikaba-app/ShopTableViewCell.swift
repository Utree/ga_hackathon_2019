//
//  ShopTableViewCell.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/19.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit
import Nuke


class ShopTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(with viewModel: ItemViewModel) {
        view.backgroundColor = UIColor.init(red: 100, green: 0, blue: 0, alpha: 0)
        
        if let name = viewModel.name {
            shopNameLabel.text = name
        }
        if let category = viewModel.category {
            categoryLabel.text = category
        }
        if let priceRange = viewModel.priceRange {
            priceRangeLabel.text = priceRange
        }
        if let distance = viewModel.distance {
            distanceLabel.text = distance
        }
        
        if let url = viewModel.thumbnail {
            Nuke.loadImage(with: url, into: thumbnailView)
        }
    }

}
