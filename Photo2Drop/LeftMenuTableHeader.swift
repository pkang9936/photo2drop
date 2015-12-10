//
//  LeftMenuTableHeader.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/9/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class LeftMenuTableHeader: UIView {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
