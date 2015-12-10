//
//  DataTableViewCell.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/8/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

struct DataTableViewCellData {
    init(imageUrl: String, text: String){
        self.imageUrl = imageUrl
        self.text = text
    }
    var imageUrl: String
    var text: String
}

class DataTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataText?.font = UIFont.italicSystemFontOfSize(16)
        self.dataText?.textColor = UIColor(hex: "9E9E9E")
    }
    
    override class func height() -> CGFloat {
        return 80
    }
    
    override func setData(data: Any?) {
        if let data = data as? DataTableViewCellData {
            self.dataImage.setRandomDownloadImage(80, height: 80)
            self.dataText.text = data.text
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
