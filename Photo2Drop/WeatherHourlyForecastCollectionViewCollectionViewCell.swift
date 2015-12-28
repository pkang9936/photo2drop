//
//  WeatherHourlyForecastCollectionViewCollectionViewCell.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/27/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import WeatherIconsKit

class WeatherHourlyForecastCollectionViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        render()
    }
    
    func render(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        hourLabel.text = dateFormatter.stringFromDate(NSDate())
        hourLabel.font = UIFont.latoFontOfSize(20)
        
        iconLabel.attributedText = WIKFontIcon.wiDaySunnyIconWithSize(30).attributedString()
        iconLabel.textColor = UIColor.whiteColor()
        
        tempsLabel.text = "5° 8°"
        tempsLabel.font = UIFont.latoFontOfSize(20)
    }

}
