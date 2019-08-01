//
//  MenuProvider.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 20.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol FetchData: class {
    
    func DataFetch(ID: String, menuN: String, desc: String, priceM: Int, menuType: String, menuImage: String)
 
}
 class MenuProvider {
    
    static var  imageURL: String?
    
    private static let _instance =  MenuProvider()
    
    weak var delegate: FetchData?
    
    
    static var  Instance: MenuProvider{
        
        return _instance
    }
    
    private init(){
        
}
 
    func sendMediaMessage( url: String){
        
         let data: Dictionary<String,Any> = [Constans.URL: url]
        
       DBProvider.Instance.mediaMessagesRef.childByAutoId().setValue(data)
        
 
    }
    func sendMedia (image: Data?,completed: @escaping Constans.DownloadComplete ){
        
        if image != nil {
            
            
            let storageref =  DBProvider.Instance.imageStorageRef.child("\(NSUUID().uuidString).jpg")
             storageref.putData(image!, metadata: nil)
            { (metadata: StorageMetadata?,err: Error?) in
                if err != nil {
            //          self.delegate?.informUserUploaded(messageUser: "Your image didn't received")
                    print("problem oluştu")
                 }
                else {
                     storageref.downloadURL(completion: { (url, err) in
                        if err != nil {
                            print("problem var")
                        }
                        if url != nil {
                             let s = url!.absoluteString
                            let str = String(describing: s)
                            self.sendMediaMessage(url: str)
                            MenuProvider.imageURL =  str
                            print(str)
                            print("evet   oldu")
                            
                            completed()

 
 
                            
                        }
                    })
                    
                    
                }
                
            }
        }
    }
    

    func  addItemMenu(ID: String, menuN: String, desc: String, priceM: Int, menuType: Type, menuImage: String) {
        
        let data: Dictionary<String, Any> = [Constans.MENUID: ID, Constans.MENUNAME: menuN, Constans.MENUDESCRİPTİON: desc, Constans.MENUPRICE: priceM, Constans.MENUTYPE: "\(menuType)", Constans.MENUIMAGE : menuImage]
        
        DBProvider.Instance.menuRef.child(ID).setValue(data)
       

 
    }
    func  deleteItemMenu(ID: String) {
        
        DispatchQueue.main.async {
            
            DBProvider.Instance.menuRef.child(ID).removeValue()

        }
        
    }
    
    
    func getMenu() {
        
        // price a göre sıralama yaptır *
       // let priceSort = NSSortDescriptor(key: "price", ascending: true)

          DBProvider.Instance.menuRef.observe(DataEventType.childAdded) { (snapshot:
            DataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                
                if let menuID = data[Constans.MENUID] as?  String {
                    
                    if let menuname = data[Constans.MENUNAME] as?  String {
                        
                        if let menuDescription = data[Constans.MENUDESCRİPTİON] as?  String {
                            
                            if let price = data[Constans.MENUPRICE] as?  Int {
                                
                                if let type = data [Constans.MENUTYPE] as? String {
                                    print("tamam")
                                    if let image = data[Constans.MENUIMAGE] as? String {
                                        
                                    
 
                                        self.delegate?.DataFetch(ID: menuID, menuN: menuname, desc: menuDescription, priceM: price,menuType: "\(type)", menuImage: image)
                                    }
                                    
                                  

                                }
                                
                            }
                            
                        }
                        
                    }
                }
            }
        }
        
 
}
}

