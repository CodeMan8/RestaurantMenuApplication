//
//  AuthProvider.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 17.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import Foundation
import FirebaseAuth
class AuthProvider {
    
    private static let _instance = AuthProvider();
    
    static var Instance: AuthProvider {
        
        return _instance
    }
 
    func currentUserID() -> String {
        
        return (Auth.auth().currentUser?.uid)!
    }
    func currentUserEmail() -> String {
        
        return (Auth.auth().currentUser?.email)!

    }
    
    
    func isLoggedIn() -> Bool {
        
        if Auth.auth().currentUser != nil {
            return true
            
            
        }
        return false
        
        
    }
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                return true
            }
            catch {
                return false
            }
            
        }
        return true
}
}
