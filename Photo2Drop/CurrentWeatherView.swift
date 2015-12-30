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
    func render(){
        iconLabel.attributedText = WIKFontIcon.wiDaySunnyIconWithSize(20).attributedString()
        weatherLabel.text = "Sunny"
        
        minTempLabel.text = "4°"
        maxTempLabel.text = "10°"
        currentLabel.text = "6°"
        
        cityLabel.text = "London"
    }
}
