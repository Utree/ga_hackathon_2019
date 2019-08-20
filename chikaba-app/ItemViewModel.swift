//
//  ItemViewModel.swift
//  chikaba-app
//
//  Created by sekiya on 2019/08/20.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import Foundation

struct ItemViewModel {
    let name: String?
    let category: String?
    let distance: String?
    let priceRange: String?
    let thumbnail: URL?
    let vacantID: Int?
    
    
    init(name: String, category: String, distance: String, priceRange: String, thumbnail: URL ,vacantID: Int){
        self.name = name as String
        self.category = category as String
        self.distance = distance as String
        self.priceRange = priceRange as String
        self.thumbnail = thumbnail as URL
        self.vacantID = vacantID as Int
    }
}
