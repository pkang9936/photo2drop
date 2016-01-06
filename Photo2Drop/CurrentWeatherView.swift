//
//  CurrentWeatherView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/24/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import LatoFont
import WeatherIconsKit

class CurrentWeatherView: UIView {
    @IBOutlet weak var cityImage: AvatarImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
   
    
    func style() {
        iconLabel.textColor = UIColor.whiteColor()
        weatherLabel.font = UIFont.latoLightFontOfSize(20)
        weatherLabel.textColor = UIColor.whiteColor()
        
        currentLabel.font = UIFont.latoLightFontOfSize(96)
        currentLabel.textColor = UIColor.whiteColor()
        
        maxTempLabel.font = UIFont.latoLightFontOfSize(18)
        maxTempLabel.textColor = UIColor.whiteColor()
        
        minTempLabel.font = UIFont.latoLightFontOfSize(18)
        minTempLabel.textColor = UIColor.whiteColor()
        
        cityLabel.font = UIFont.latoLightFontOfSize(18)
        cityLabel.textColor = UIColor.whiteColor()
        cityLabel.textAlignment = .Right
    }
    
    /*
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
       style()
    }
    
    
}

extension CurrentWeatherView{
    func render(weatherCondition: WeatherCondition){
        iconLabel.attributedText = iconStringFromIcon(weatherCondition.icon!, size: 20)
        weatherLabel.text = weatherCondition.weather
        
        var usesMetric = false
        
        if let localSystem = NSLocale.currentLocale().objectForKey(NSLocaleUsesMetricSystem) as? Bool {
            usesMetric = localSystem
        }
        
        if usesMetric {
            minTempLabel.text = "\(weatherCondition.minTempCelsius.roundToInt())°"
            maxTempLabel.text = "\(weatherCondition.maxTempCelsius.roundToInt())°"
            currentLabel.text = "\(weatherCondition.tempCelsius.roundToInt())°"
        } else {
            minTempLabel.text = "\(weatherCondition.minTempFahrenheit.roundToInt())°"
            maxTempLabel.text =  "\(weatherCondition.maxTempFahrenheit.roundToInt())°"
            currentLabel.text = "\(weatherCondition.tempFahrenheit.roundToInt())°"
        }
        
        cityLabel.text = weatherCondition.cityName ?? ""
    }
    
    func iconStringFromIcon(icon: IconType, size: CGFloat) -> NSAttributedString {
        switch icon {
        case .i01d:
            return WIKFontIcon.wiDaySunnyIconWithSize(size).attributedString()
        case .i01n:
            return WIKFontIcon.wiNightClearIconWithSize(size).attributedString()
        case .i02d:
            return WIKFontIcon.wiDayCloudyIconWithSize(size).attributedString()
        case .i02n:
            return WIKFontIcon.wiNightCloudyIconWithSize(size).attributedString()
        case .i03d:
            return WIKFontIcon.wiDayCloudyIconWithSize(size).attributedString()
        case .i03n:
            return WIKFontIcon.wiNightCloudyIconWithSize(size).attributedString()
        case .i04d:
            return WIKFontIcon.wiCloudyIconWithSize(size).attributedString()
        case .i04n:
            return WIKFontIcon.wiCloudyIconWithSize(size).attributedString()
        case .i09d:
            return WIKFontIcon.wiDayShowersIconWithSize(size).attributedString()
        case .i09n:
            return WIKFontIcon.wiNightShowersIconWithSize(size).attributedString()
        case .i10d:
            return WIKFontIcon.wiDayRainIconWithSize(size).attributedString()
        case .i10n:
            return WIKFontIcon.wiNightRainIconWithSize(size).attributedString()
        case .i11d:
            return WIKFontIcon.wiDayThunderstormIconWithSize(size).attributedString()
        case .i11n:
            return WIKFontIcon.wiNightThunderstormIconWithSize(size).attributedString()
        case .i13d:
            return WIKFontIcon.wiSnowIconWithSize(size).attributedString()
        case .i13n:
            return WIKFontIcon.wiSnowIconWithSize(size).attributedString()
        case .i50d:
            return WIKFontIcon.wiFogIconWithSize(size).attributedString()
        case .i50n:
            return WIKFontIcon.wiFogIconWithSize(size).attributedString()
        }
    }
}
