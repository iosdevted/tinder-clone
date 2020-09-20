//
//  Extensions.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 20/09/2020.
//

import Foundation
import UIKit

extension Date {
    
    func longDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func stringDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMMyyyyHHmmss"
        return dateFormatter.string(from: self)
    }
}

extension UIColor {
    
    func primary() -> UIColor {
        return UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1)
    }
    
    func tabBarUnselected() -> UIColor {
        return UIColor(red: 255/255, green: 216/255, blue: 223/255, alpha: 1)
    }
    
}
