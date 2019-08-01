//
//  AdminController.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 18.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit
  import SDWebImage


class AdminController: UIViewController {
  //   var realImage: UIImage?
    
     static  var foods = [Menu]()
     static var drinks = [Menu]()
     static var  deserts = [Menu]()
 
    @IBOutlet weak var table: UITableView!
    
    @IBAction func addMenu(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: Constans.ADMINNEWMENUSEGUE, sender: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        MenuProvider.Instance.delegate = self
        MenuProvider.Instance.getMenu()
        
      
 
        /*
        
        let c1 = Category(imageURL: "", imageDescription: "aevet")
        let c2 = Category(imageURL: "", imageDescription: "adasdada")
        
        AdminController.categorys.append(c1)
        AdminController.categorys.append(c2)
 */

        // Do any additional setup after loading the view.
    }
    
 

    @IBAction func Logout(_ sender: UIBarButtonItem) {
        
        if AuthProvider.Instance.logOut(){

        dismiss(animated: true, completion: nil)
            
           AdminController.foods.removeAll()
             AdminController.drinks.removeAll()
            AdminController.deserts.removeAll()
         }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindtoBack(_sender : UIStoryboardSegue){
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == Constans.ADMINMENU_SEGUE {
            
             if  let dest = segue.destination as? AdminItemController {
                
 
                if let  data  = sender as? NSDictionary {
                    print("olmamıskardes")

                    
                    if let name = data["name"]  as? String , let des = data["description"] as? String, let price = data["price"] as? Int, let type = data["type"] as? String   {
                        
                        
                          dest.menuName = name
                        dest.menuDescription = des
                        dest.menuPrice = "\(price)"
                        dest.menuType  = "\(type)"
                        print("başarıl")

 
                    }
                    
                
                    
                }
                
 
            
        }
        }
    }
    
        
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        
        self.table.isEditing = !self.table.isEditing
        sender.title = (self.table.isEditing) ? "Done" : "Edit"
        
    }
    private func deleteDB(menu: Menu) {
        
        
           MenuProvider.Instance.deleteItemMenu(ID: menu.menuID)
        
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

extension AdminController: UITableViewDelegate,UITableViewDataSource,FetchData {
    
    func DataFetch(ID: String, menuN: String, desc: String, priceM: Int, menuType: String, menuImage: String) {
        
 
 
            if   menuType  == "Food" {
                
                let myMenu =    Menu(image: menuImage, price: priceM, description: desc, menuName: menuN, menuType: Type.Food, menuID: ID)
 
                AdminController.foods.append(myMenu)
 
            }
            if   menuType  == "Drink" {
 
                let myMenu =    Menu(image: menuImage, price: priceM, description: desc, menuName: menuN, menuType: Type.Drink, menuID: ID)
                AdminController.drinks.append(myMenu)
 
            }
            if   menuType  == "Desert" {
 
                
                let myMenu =    Menu(image: menuImage, price: priceM, description: desc, menuName: menuN, menuType: Type.Desert, menuID: ID)
                AdminController.deserts.append(myMenu)
 
            }
            
            
        DispatchQueue.main.async {
            self.table.reloadData()
        }
      
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch (section) {
        case 0:
            return AdminController.foods.count
        case 1:
            return AdminController.drinks.count
        default:
            return AdminController.deserts.count
        }
 
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            switch (indexPath.section) {
            case 0:
              let menu1 =   AdminController.foods.remove(at: indexPath.row)
                 deleteDB(menu: menu1)
                
            case 1:
               let menu2 =   AdminController.drinks.remove(at: indexPath.row)
               
                deleteDB(menu: menu2)
                
            default:
               let menu3 =   AdminController.deserts.remove(at: indexPath.row)
                 deleteDB(menu: menu3)
            }
            DispatchQueue.main.async {
                self.table.reloadData()
            }
 
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        table.register(UINib(nibName: "viewmenus",bundle: nil), forCellReuseIdentifier: Constans.CATEGORY_CELL)
        
  
        if let  cell = table.dequeueReusableCell(withIdentifier: Constans.CATEGORY_CELL, for: indexPath) as? menustablecell {
             

            if  indexPath.section  == 0       {
                
                let yemekler = AdminController.foods[indexPath.row]
                
                cell.updateUI(menus: yemekler)
 //                cell.imageMenu.image = realImage
                
                return cell
                
            }
             if  indexPath.section  == 1       {
                
                let içecekler = AdminController.drinks[indexPath.row]

                cell.updateUI(menus: içecekler)
 
            //   cell.imageMenu.image = realImage

 
                 return cell
                
            }
              if  indexPath.section  == 2       {
                
                let tatlılar = AdminController.deserts[indexPath.row]
                cell.updateUI(menus: tatlılar)
 
             //  cell.imageMenu.image =  realImage

 
                 return cell
                
            }
 
         
        }
        
        return menustablecell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         if  indexPath.section  == 0       {
            
          let yemek =    AdminController.foods[indexPath.row]
            let myDictionary:  Dictionary<String,Any> = ["name": yemek.menuName , "description" : yemek.description , "price": yemek.price,"type": "\(yemek.menuType)"]

 
        performSegue(withIdentifier: Constans.ADMINMENU_SEGUE, sender: myDictionary)
            
        }
        if  indexPath.section  == 1       {
            let icecek =    AdminController.drinks[indexPath.row]
            let myDictionary:  Dictionary<String,Any> = ["name": icecek.menuName , "description" : icecek.description , "price": icecek.price,"type": "\(icecek.menuType)"]
            
            
            performSegue(withIdentifier: Constans.ADMINMENU_SEGUE, sender: myDictionary)
        }

        if  indexPath.section  == 2       {
            
            let tatlı =    AdminController.deserts[indexPath.row]
            let myDictionary:  Dictionary<String,Any> = ["name": tatlı.menuName , "description" : tatlı.description , "price": tatlı.price,"type": "\(tatlı.menuType)"]
            
            
            performSegue(withIdentifier: Constans.ADMINMENU_SEGUE, sender: myDictionary)
        }

 
    }
    
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    
   
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
          let label = UILabel()
          label.backgroundColor = UIColor.blue
        switch (section) {
        case 0:
            label.text = " \(Type.Food)"
            return label
        case 1:
            label.text = " \(Type.Drink)"

            return label
        default:
            label.text = " \(Type.Desert)"

            return label
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 25
    }
    
   
    
    
   
}
