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

    @IBOutlet weak var vacantColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(with viewModel: ItemViewModel) {
        print(viewModel.vacantID)
        if viewModel.vacantID == 4 { self.vacantColor.backgroundColor = UIColor.init(red: 0, green: 100, blue: 0, alpha: 100)
        }
        if viewModel.vacantID == 5 {
            self.vacantColor.backgroundColor = UIColor.init(red: 100, green: 100, blue: 0, alpha: 100)
        }
        if viewModel.vacantID == 6 {
            self.vacantColor.backgroundColor = UIColor.init(red: 100, green: 0, blue: 0, alpha: 100)
        }
        
        
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
            let array = ["https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1473093226795-af9932fe5856?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            
            
            Nuke.loadImage(with: URL(string: array[randomIndex])!
                , into: thumbnailView)
        }
    }

}
