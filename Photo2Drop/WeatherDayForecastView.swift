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
    }
    
    func render(weatherCondition: WeatherCondition){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.stringFromDate(weatherCondition.time)
        iconLabel.attributedText = iconStringFromIcon(weatherCondition.icon!, size: 30)
        
        var usesMetric = false
        
        if let localeSystem = NSLocale.currentLocale().objectForKey(NSLocaleUsesMetricSystem) as? Bool {
            usesMetric = localeSystem
        }
        
        if usesMetric {
            tempsLabel.text = "\(weatherCondition.minTempCelsius.roundToInt())°     \(weatherCondition.maxTempCelsius.roundToInt())°"
        } else {
            tempsLabel.text = "\(weatherCondition.minTempFahrenheit.roundToInt())°     \(weatherCondition.maxTempFahrenheit.roundToInt())°"
        }
        
        dayLabel.font = UIFont.latoFontOfSize(20)
        tempsLabel.font = UIFont.latoFontOfSize(20)
        
    }
}
