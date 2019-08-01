//
//  RoundTextField.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 15.11.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit
@IBDesignable

class RoundTextField : UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet{
            
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet{
        layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var bgColor: UIColor? {
        didSet{
            backgroundColor = bgColor
        }
    }
    @IBInspectable var placeholderColor : UIColor? {
        didSet{
            
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey : placeholderColor])
            attributedPlaceholder = str
        }
    }
    
    
    
}
