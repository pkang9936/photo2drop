//
//  WeatherDayForecastView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/27/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import WeatherIconsKit

class WeatherDayForecastView: UIView {
    @IBOutlet weak var iconLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        render()
    }
    
    func render() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.stringFromDate(NSDate())
        iconLabel.attributedText = WIKFontIcon.wiDaySunnyIconWithSize(30).attributedString()
        
        tempsLabel.text = "7°      11°"
        
        dayLabel.font = UIFont.latoFontOfSize(20)
        tempsLabel.font = UIFont.latoFontOfSize(20)
        
    }
}
