//
 //  RestaurantMenuApp
//
//  Created by Bartu akman on 13.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit

class HomePage: UIViewController {
    
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    public var isSearching = false
    var filteredData = [Menu]()
 
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
 
        if AuthProvider.Instance.logOut(){
            
            dismiss(animated: true, completion: nil)
            
            AdminController.foods.removeAll()
            AdminController.drinks.removeAll()
            AdminController.deserts.removeAll()
        }
    }
    
     
    
    @IBAction func SegmentChanged(_ sender: Any) {
  
      //  let index  = (sender as AnyObject).selectedSegmentIndex
        
        filterList()
  
    }
    
  

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        MenuProvider.Instance.delegate = self
        MenuProvider.Instance.getMenu()

        
        
     }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == Constans.MENU_SEGUE {
            
            if  let dest = segue.destination as? UserItemController {
                
                
                if let  data  = sender as? NSDictionary {
 
                    
                    if let name = data["name"]  as? String , let des = data["description"] as? String, let price = data["price"] as? Int, let type = data["type"] as? String, let id = data["type"] as? String   {
                        
                        
                        dest.menuName = name
                        dest.menuDescription = des
                        dest.menuPrice = "\(price)"
                         dest.menuType  = "\(type)"
                        UserItemController.menuID = id
                       
                         print("başarıl")
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
            }
        }
    }
    func filterList() {
        let index =  selectedSegment.selectedSegmentIndex
        switch index {
            
        case 0:
            AdminController.foods.sort { $0.menuName > $1.menuName }
            AdminController.drinks.sort { $0.menuName > $1.menuName }
            AdminController.deserts.sort { $0.menuName > $1.menuName }
         case 1:
            AdminController.foods.sort { $0.price < $1.price }
            AdminController.drinks.sort { $0.price < $1.price }
            AdminController.deserts.sort { $0.price < $1.price }
 
        default:
           
            AdminController.foods.sort { $0.date > $1.date}
            AdminController.drinks.sort { $0.date > $1.date }
            AdminController.deserts.sort { $0.date > $1.date }
          
 
            
        }
        
        DispatchQueue.main.async {
            
           self.tableview.reloadData()
              }

 
 
     }
    
    
    
  
   // yap
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension  HomePage: UITableViewDelegate,UITableViewDataSource, FetchData, UISearchBarDelegate {
    
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
 
 
    filterList()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            
            return filteredData.count
        }
        else {
        
        switch (section) {
        case 0:
            return AdminController.foods.count
        case 1:
            return AdminController.drinks.count
        default:
            return AdminController.deserts.count
        }
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: "viewmenus",bundle: nil), forCellReuseIdentifier: Constans.CATEGORY_CELL)

        
        if let  cell = tableView.dequeueReusableCell(withIdentifier: Constans.CATEGORY_CELL, for: indexPath) as? menustablecell {
 
            if isSearching {
 
             let    text  = filteredData[indexPath.row].menuName
                print("texttt")
                print(text)
               //  cell.updateUI(menus: text)
                cell.menuName.text = text.lowercased()
                
                return cell
                
            }
            else {
            
            if  indexPath.section  == 0       {
                
                let yemekler = AdminController.foods[indexPath.row]
                
                cell.updateUI(menus: yemekler)
 
                return cell
                
            }
            if  indexPath.section  == 1       {
                
                let içecekler = AdminController.drinks[indexPath.row]
                
                cell.updateUI(menus: içecekler)
                
 
                
                return cell
                
            }
            if  indexPath.section  == 2       {
                
                let tatlılar = AdminController.deserts[indexPath.row]
                cell.updateUI(menus: tatlılar)
                
 
                
                return cell
                
            }
            }
            
            
        }
        
        return menustablecell()

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if  indexPath.section  == 0       {
            
            let yemek =    AdminController.foods[indexPath.row]
            let myDictionary:  Dictionary<String,Any> = ["name": yemek.menuName , "description" : yemek.description , "price": yemek.price,"type": "\(yemek.menuType)","id":  yemek.menuID]
            
            
            performSegue(withIdentifier: Constans.MENU_SEGUE, sender: myDictionary)
            
        }
        if  indexPath.section  == 1       {
            let icecek =    AdminController.drinks[indexPath.row]
            let myDictionary:  Dictionary<String,Any> = ["name": icecek.menuName , "description" : icecek.description , "price": icecek.price,"type": "\(icecek.menuType)","id":  icecek.menuID]
            
            
            performSegue(withIdentifier: Constans.MENU_SEGUE, sender: myDictionary)
        }
        
        if  indexPath.section  == 2       {
            
            let tatlı =    AdminController.deserts[indexPath.row]
            let myDictionary:  Dictionary<String,Any> = ["name": tatlı.menuName , "description" : tatlı.description , "price": tatlı.price,"type": "\(tatlı.menuType)","id":  tatlı.menuID]
            
            
            performSegue(withIdentifier: Constans.MENU_SEGUE, sender: myDictionary)
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isSearching  {
            
            return 1
        }
        return 3
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        if isSearching {
            label.text = "Search"
            
            return label
        }
        else {
        
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
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 25
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text  == nil || searchBar.text == "" {
            
            isSearching = false
            view.endEditing(true)
            
            DispatchQueue.main.async {
                
                self.tableview.reloadData()
            }
        }
        else {
            
            isSearching = true
            
             let searchFoods = AdminController.foods.filter({ $0.menuName == searchBar.text?.lowercased() })
             let searchDrinks = AdminController.drinks.filter({ $0.menuName == searchBar.text?.lowercased() })
            let searchDeserts = AdminController.deserts.filter({ $0.menuName == searchBar.text?.lowercased() })
            
            filteredData = searchFoods + searchDrinks + searchDeserts

            
            DispatchQueue.main.async {
                
                self.tableview.reloadData()
            }
        }
            
        }
        
    }

    

