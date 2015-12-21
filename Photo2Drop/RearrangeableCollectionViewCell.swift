//
//  DraggableCollectionViewCell.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/21/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class RearrangeableCollectionViewCell: UICollectionViewCell {
    
    var baseBackgroundColor: UIColor?
    
    var dragging: Bool = false {
        didSet {
            
            if dragging == true {
                self.baseBackgroundColor = self.backgroundColor
                self.backgroundColor = UIColor.redColor()
            } else {
                self.backgroundColor = self.baseBackgroundColor
            }
        }
    }
    
}
