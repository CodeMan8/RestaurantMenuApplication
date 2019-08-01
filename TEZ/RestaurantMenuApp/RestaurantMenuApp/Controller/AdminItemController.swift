//
//  AdminItemController.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 22.11.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit

class AdminItemController: UIViewController {
   
    @IBOutlet weak var descriptionText: UITextView!{
        didSet{
            descriptionText.text = menuDescription
        }
    }
    @IBOutlet weak var menuNameLbl: UILabel!{
        didSet{
            menuNameLbl.text = menuName
         }
    }
    @IBOutlet weak var menuTypeLbl: UILabel!{
        didSet{
            menuTypeLbl.text = menuType
        }
    }
    @IBOutlet weak var priceLbl: UILabel!{
        didSet{
            
        priceLbl.text = menuPrice
            
        }
    }
    var menuName: String = ""
    var menuType: String = ""
    var menuDescription: String = ""
    var menuPrice: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(menuDescription)
        print(menuName)
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            
        if let dest = segue.destination as? AdminMenuController {
            
             dest.menuname = menuName
            dest.menuprice = Int(menuPrice)!
            dest.menudescription = menuDescription
            dest.menutype =  menuTypeIndex()
 
        }
    }
    
    
    func menuTypeIndex () -> Int{
        
        if menuType == "Food" {
            
            return 0

        } else if menuType == "Drink" {
            
            return 1
            
        } else {
            
            return 2
        }
        
        
    }
    
    @IBAction func updateMenu(_ sender: RoundButton) {
        
        
         performSegue(withIdentifier: Constans.ADMINNEWMENUSEGUE, sender: nil)

        
    }
    
    

}
