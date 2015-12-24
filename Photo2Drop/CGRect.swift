//
//  CGRect.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/24/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    func printRect(name: String) -> Void {
        NSLog("\n\(name) = (x:\(self.origin.x),y:\(self.origin.y),w:\(self.width),h:\(self.height))")
    }
}