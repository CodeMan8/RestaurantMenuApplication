//
//  DateExtension.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 23.11.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit

extension Date {
    
func dateFormattedString(_ date: Date) -> String {
    
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
 
    return formatter.string(from: date)
    }
    
    func date (_ date: String) -> Date {
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.date(from: date)!
    }
    
}
