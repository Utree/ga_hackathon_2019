//
//  ShopInfomation.swift
//  chikaba-app
//
//  Created by 西俣雷斗 on 2019/08/20.
//  Copyright © 2019 西俣雷斗. All rights reserved.
//

import UIKit
import MapKit
import Nuke

class ShopInfomation: UIViewController {
    var Name = ""
    var imagePath = "https://bankkita.com/images/mexican-food-png-3.png"
    var url = ""
    var latitude = 35.7020691
    var longitude = 139.7753269
    var descrip = ""
    
    @IBOutlet weak var shopImage: UIImageView!
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopDescription: UITextView!
    
    @IBOutlet weak var webpageButton: UIButton!
    
    @IBOutlet weak var pinnedMapView: MKMapView!
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    @IBAction func forwardButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopName.text = Name
        webpageButton.setTitle(url, for: .normal)
        
        shopDescription.text = descrip
        
//        mapに指すpinの設定
        pointAno.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        pinnedMapView.addAnnotation(pointAno)
        
        // 画像を表示
        getImage()
    }
    
    //    画像の表示
    private func getImage() {
        let array = ["https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", "https://images.unsplash.com/photo-1473093226795-af9932fe5856?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"]
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        
        Nuke.loadImage(with: URL(string: array[randomIndex])!, into:shopImage)
//        do {
//            try Nuke.loadImage(with: URL(string: imagePath)!, into:shopImage)
//        } catch {
//            try Nuke.loadImage(with: URL(string: "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60")!, into:shopImage)
//        }
    }
    
}
