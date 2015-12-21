//
//  DraggableCollectionViewCell.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/21/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class RearrangeableCollectionViewCell: RoundBorderCollectionViewCell {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var albumImg: UIImageView!
    var baseBackgroundColor: UIColor?
    
    var dragging: Bool = false {
        didSet {
            
            if dragging == true {
                self.baseBackgroundColor = self.backgroundColor
                self.backgroundColor = UIColor.redColor()
                self.blurView.hidden = false
                self.layer.borderColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0).CGColor
            } else {
                self.backgroundColor = self.baseBackgroundColor
                self.blurView.hidden = true
                self.layer.borderColor = UIColor.whiteColor().CGColor
            }
        }
    }
    
}
