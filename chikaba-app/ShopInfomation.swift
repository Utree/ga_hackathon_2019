//
//  ShopInfomation.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/20.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit
import MapKit

class ShopInfomation: UIViewController {
    var Name = ""
    var Image = ""
    var url = ""
    var latitude = 35.7020691
    var longitude = 139.7753269
    
    @IBOutlet weak var shopImage: UIImageView!
    
    @IBOutlet weak var shopName: UILabel!
   
    @IBOutlet weak var URL: UIButton!
    
    @IBOutlet weak var pinnedMapView: MKMapView!
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    @IBAction func forwardButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopName.text = Name
        URL.setTitle(url, for: .normal)
        
        pointAno.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        pinnedMapView.addAnnotation(pointAno)
    }
    
}
