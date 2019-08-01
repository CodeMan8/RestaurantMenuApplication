//
//  Menu.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 21.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import Foundation
class Menu {
    
    private var _image: String!
    private var _price: Int!
    private var _description: String!
    private var _menuName: String!
    private var _menuType: Type!
    private var _menuID: String!
     private var  _date : Date = Date()
    
    

    var  date : Date
         {
    
    return _date
    
    }

    var image: String {
        return _image
    }
    
     
    
    var description: String {
        return _description
    }
    var price: Int {
        return _price
    }
    var menuName: String {
        return _menuName
    }
    var menuType: Type {
        return _menuType
    }
    
    var menuID: String {
        return _menuID
    }
    init(image: String, price: Int, description: String, menuName: String, menuType: Type, menuID: String) {
        
        _image = image
        _price = price
        _description = description
        _menuName = menuName
        _menuType = menuType
        _menuID = menuID
         _date = date
 
        
     }
    
    
    
    
    
    
    
    
    
}
