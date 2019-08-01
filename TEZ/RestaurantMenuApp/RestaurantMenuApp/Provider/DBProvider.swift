//
//  DBProvider.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 14.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import Foundation
 import FirebaseDatabase
import FirebaseStorage



class DBProvider {
    private static let _instance =  DBProvider()
    
    weak var delegate: FetchData?
    
    
     static var  Instance: DBProvider{
        
        return _instance
    }
    
    private init(){
        
    }
    
    var dbRef: DatabaseReference {
        return Database.database().reference()
    }
    var clientRef : DatabaseReference{
        
        return dbRef.child(Constans.CLIENT)
    }
    var storageRef : StorageReference {
        
        return Storage.storage().reference(forURL: "gs://restaurantapp-8683e.appspot.com")
    }
    
    var categoryRef: DatabaseReference {
        return dbRef.child(Constans.CATEGORY)
    }
    var menuRef: DatabaseReference {
        return dbRef.child(Constans.MENU)
    }
    var mediaMessagesRef : DatabaseReference {
        return dbRef.child(Constans.MEDIA_MESSAGES)
    }
    
    var locationRef : DatabaseReference {
        return dbRef.child(Constans.LOCATİON)
    }
    
    var imageStorageRef : StorageReference {
        
        return storageRef.child(Constans.IMAGE_STORAGE)
    }
    func saveUser(withID: String, email: String, password: String){
        
        let data: Dictionary<String,Any> = [Constans.EMAIL: email,Constans.PASSWORD: password]
        clientRef.child(withID).setValue(data)
 
        
    }
  
    
    
    
}
