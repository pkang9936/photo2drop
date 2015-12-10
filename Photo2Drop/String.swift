//
//  String.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/8/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation

extension String {
    static func className (aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
    
    func substring(from: Int) -> String {
        return self.substringFromIndex(self.startIndex.advancedBy(from))
    }
    
    var length: Int {
        return self.characters.count
    }
}