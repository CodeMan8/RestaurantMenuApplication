//
//  UserItemController.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 25.11.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit

class UserItemController: UIViewController {
    
      static var orders = [Menu]()

    @IBOutlet weak var menuNameLbl: UILabel!{
        didSet{
            menuNameLbl.text = menuName
        }
    }
    @IBOutlet weak var menuDescText: UITextView!{
        didSet{
            menuDescText.text = menuDescription
        }
    }
    @IBOutlet weak var priceLbl: UILabel!{
        didSet{
            priceLbl.text = menuPrice
            
        }
    }
    @IBOutlet weak var typeLbl: UILabel!{
        didSet{
            typeLbl.text = menuType
            
        }
    }
   static var menuID:String = ""
    
    var menuName: String = ""
    var menuType: String = ""
    var menuDescription: String = ""
    var menuPrice: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addToOrder(_ sender: RoundButton) {
        
     // let newMenu =    Menu(image: "", price: Int(menuPrice)!, description: menuDescription, menuName: menuName, menuType: Type.Desert, menuID: UserItemController.menuID)
        
     //   let id = AuthProvider.Instance.currentUserID()
        
       // DBProvider.Instance.menuRef.child(id).setValue(newMenu)

        
      //    UserItemController.orders.append(newMenu)
        
        performSegue(withIdentifier: "map", sender: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FavoriteButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
