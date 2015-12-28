//
//  UIView.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/8/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import UIKit
import PlummerFramework

extension UIView {

    class func loadNib<T: UIView>(viewType: T.Type) -> T {
        let className = String.className(viewType)
        return NSBundle(forClass: viewType).loadNibNamed(className, owner: nil, options: nil).first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    func printCoordinate() {
        let msg = "x:\(self.frame.origin.x),y:\(self.frame.origin.y)"
        Log.info(message: msg, data: nil)
    }
    
    // MARK: - Frame
    
    /**
    Redefines the height of the view
    
    :param: height The new value for the view's height
    */
    func setHeight(height: CGFloat) {
        
        var frame: CGRect = self.frame
        frame.size.height = height
        
        self.frame = frame
    }
    
    /**
     Redefines the width of the view
     
     :param: width The new value for the view's width
     */
    func setWidth(width: CGFloat) {
        
        var frame: CGRect = self.frame
        frame.size.width = width
        
        self.frame = frame
    }
    /**
     Redefines X position of the view
     
     :param: x The new x-coordinate of the view's origin point
     */
    func setX(x: CGFloat) {
        
        var frame: CGRect = self.frame
        frame.origin.x = x
        
        self.frame = frame
    }
    
    /**
     Redefines Y position of the view
     
     :param: y The new y-coordinate of the view's origin point
     */
    func setY(y: CGFloat) {
        
        var frame: CGRect = self.frame
        frame.origin.y = y
        
        self.frame = frame
    }
}