//
//  AdminMenuController.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 20.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit
import MobileCoreServices

class AdminMenuController: UIViewController {
    var menuname = ""
    var menudescription = ""
    var menutype = 0
    var menuprice = 0

    @IBOutlet weak var priceText: UITextField!{
        didSet{
            priceText.text = "\(menuprice)"
        }
    }
    @IBOutlet weak var descriptionText: UITextField!{
        didSet{
            descriptionText.text = menudescription
        }
    }
    @IBOutlet weak var menuNameText: UITextField!{
        didSet{
        menuNameText.text = menuname
        }
    }
    @IBOutlet weak var nutrientType: UISegmentedControl!{
        didSet{
            nutrientType.selectedSegmentIndex = menutype
            
        }
    }
 
 


      let picker = UIImagePickerController()
     static var  imageURl: String?
     @IBOutlet weak var imageView: UIImageView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
       

 

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
     }
 
    
    
    
    @IBAction func chooseImage(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Media Messages", message: "Please select a media", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let photos = UIAlertAction(title: "Photos", style: .default) { (alert: UIAlertAction) in
            
            self.chooseMedia(type: kUTTypeImage)
         }
        
        alert.addAction(photos)
        alert.addAction(cancel)
        
       present(alert, animated: true, completion: nil)
        
    }
    private func chooseMedia(type: CFString) {
        
        picker.mediaTypes = [type as String]
        present(picker, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         if let destVC = segue.destination as? AdminController {
            
            DispatchQueue.main.async {
                
                destVC.table.reloadData()

            }
        }
        
    }
 
    
   private func updateDB(menu: Menu) {
        

         MenuProvider.Instance.addItemMenu(ID: menu.menuID, menuN: menu.menuName, desc: menu.description, priceM: menu.price,menuType: menu.menuType,menuImage: menu.image)
 
    }
 
    @IBAction func addMenuButton(_ sender: UIButton) {

        menuprice = Int(priceText.text!)!
        menuname = (menuNameText.text?.lowercased())!
        menudescription = descriptionText.text!
        
            
                 if imageView.image != nil  {
 

            switch nutrientType.selectedSegmentIndex {
            case 0:
                let  IDkey = DBProvider.Instance.menuRef.childByAutoId().key
                
                let     foodmenu =    Menu(image: MenuProvider.imageURL!, price: menuprice, description: menudescription, menuName: menuname, menuType: Type.Food, menuID: IDkey)
               // AdminController.foods.append(foodmenu)
                 self.updateDB(menu : foodmenu)


                break
            case 1:
                let  IDkey = DBProvider.Instance.menuRef.childByAutoId().key

                let drinkmenu =    Menu(image: MenuProvider.imageURL!, price: menuprice, description: menudescription, menuName: menuname, menuType: Type.Drink, menuID: IDkey)

               //   AdminController.drinks.append(drinkmenu)
                self.updateDB(menu : drinkmenu)


                break
            case 2:
                let  IDkey = DBProvider.Instance.menuRef.childByAutoId().key

                let desertmenu =    Menu(image: MenuProvider.imageURL!, price: menuprice, description: menudescription, menuName: menuname, menuType: Type.Desert, menuID: IDkey)

               //   AdminController.deserts.append(desertmenu)
                 self.updateDB(menu : desertmenu)
 
                break
                
            default:
                break
            }
 
                    
            }
                 else {
                    showAlert(title: "You need to  choose an  image")
                    
                }
        
        
        
       
     }
    func showAlert(title: String) {
        
        let alert =      UIAlertController(title: title, message: "Please choose image for your menu. İf you chose  an image wait for image upload", preferredStyle: UIAlertControllerStyle.actionSheet)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
        
    }

}
extension AdminMenuController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
         if let pic = info[UIImagePickerControllerOriginalImage]  as? UIImage {
            
              print("tamam")
            
             let data = UIImageJPEGRepresentation(pic, 0.01)
          
                 MenuProvider.Instance.sendMedia(image: data, completed: {
                    
                      DispatchQueue.main.async {
                        
                    self.imageView.image = pic
 
                          }
                    
                })
        
 
        }
        
         self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
