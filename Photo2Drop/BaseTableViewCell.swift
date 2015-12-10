//
//  BaseTableViewCell.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/8/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

public class BaseTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String.className(self)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public class func height() -> CGFloat {
        return 48
    }
    
    public func setData(data: Any?) {
        self.backgroundColor = UIColor(hex: "F1F8E9")
        self.textLabel?.font = UIFont.italicSystemFontOfSize(18)
        self.textLabel?.textColor = UIColor(hex: "9E9E9E")
        if let menuText = data as? String {
            self.textLabel?.text = menuText
        }
    }
    
    public override func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
}
