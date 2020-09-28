//
//  FirebaseListener.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 19/09/2020.
//

import Foundation
import Firebase

class FirebaseListener {
    
    static let shared = FirebaseListener()
    
    private init() {
        
    }
    
    //MARK: - Fuser
    func downloadCurrentUserFromFirebase(userId: String, email: String) {
     
        FirebaseReference(.User).document(userId).getDocument { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if snapshot.exists {
                
                let user = FUser(_dictionary: snapshot.data() as! NSDictionary)
                user.saveUserLocally()
                
                
                
            } else {
                //first login
                
                if let user = userDefaults.object(forKey: kCURRENTUSER) {
                    FUser(_dictionary: user as! NSDictionary).saveUserToFireStore()
                }
            }
            
        }
    }
    
}
