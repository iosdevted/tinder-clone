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
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else {
            return 0
        }
        
        return end - start 
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

extension UIImage {
    
    var isPortrait: Bool { return size.height > size.width }
    var isLandscape: Bool { return size.width > size.height }
    var breadth : CGFloat { return min(size.width, size.height)}
    var breadthSize : CGSize { return CGSize(width: breadth, height: breadth)}
    var breadthRect: CGRect { return CGRect(origin: .zero, size: breadthSize)}
    
    var circleMasked: UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
