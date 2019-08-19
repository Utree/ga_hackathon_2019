//
//  ItemTableViewCell.swift
//  chikaba-app
//
//  Created by sekiya on 2019/08/20.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit
import Nuke

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(with viewModel: ItemViewModel) {
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
