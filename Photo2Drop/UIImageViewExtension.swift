//
//  UIImageViewExtension.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 11/19/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func didChangeRoundCorner () {
        layer.cornerRadius = frame.size.height / 7
        clipsToBounds = true
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.grayColor().CGColor
    }
}