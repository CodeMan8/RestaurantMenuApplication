//
//  menustablecell.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 23.11.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit
import SDWebImage

class menustablecell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var menuDesc: UITextView!
     @IBOutlet weak var imageNames: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuPrice: UILabel!
    
    func updateUI(menus: Menu) {
        
        menuName.text = menus.menuName
        menuDesc.text = menus.description
        menuPrice.text = "\(menus.price)"
        imageLoad(url: menus.image)
        
        
        
    }
    
    func imageLoad(url: String){
        
        let url = NSURL(string: url)
        
        var request = URLRequest(url: url! as URL)

        URLSession.shared.dataTask(with: request) { (data, responses, error) in
            
            if error != nil {
                print(error)
                return
                
            }
            DispatchQueue.main.async {
        
                self.imageNames.image = UIImage(data: data!)
            }
            
        }.resume()
            
        }
        
        
    
    override func setSelected(_ selected: Bool, animated: Bool) {
            
        super.setSelected(selected, animated: animated)

    }

}
