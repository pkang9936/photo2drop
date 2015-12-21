
//
//  RoundBorderCollectionViewCell.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/19/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class RoundBorderCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 3.0
    }
}
