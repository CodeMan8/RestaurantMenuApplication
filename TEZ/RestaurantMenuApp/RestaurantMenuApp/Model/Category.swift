//
//  Category.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 15.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import Foundation
class Category {
    
    private var _imageURL: String!
    private var _imageDescription: String!
 
    var imageURL: String {
        return _imageURL
    }

    
    
    var imageDescription: String {
        return _imageDescription
    }
    
    init(imageURL: String, imageDescription: String) {
        
        _imageURL = imageURL
         _imageDescription = imageDescription
    }
}
