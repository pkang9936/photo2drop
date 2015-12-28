//
//  WeatherViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/24/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import Cartography
import FXBlurView

class WeatherViewController: SWFrontViewController {
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var currentWeatherViewWrapper: UIView!
    
    @IBOutlet weak var daysForecastView: WeatherDaysForecastView!
    var currentWeatherView: CurrentWeatherView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.currentWeatherView = CurrentWeatherView.loadNib()
        
        currentWeatherViewWrapper.addSubview(self.currentWeatherView)
        
        let currentWeatherInset: CGFloat = CGFloat(view.frame.height) - CGFloat(currentWeatherView.frame.height) - 10
        let y = (currentWeatherView.superview?.frame.origin.y)! + currentWeatherInset
        //currentWeatherView.frame = CGRectOffset(currentWeatherView.frame, 0, y)
        
        let newConstraint = NSLayoutConstraint(
            item: currentWeatherViewWrapper,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: currentWeatherViewWrapper.superview,
            attribute: .Top,
            multiplier: 1.0,
            constant: y)
        
        self.renderSubviews()
//        self.view.removeConstraint(self.topConstraint)
//        self.view.addConstraint(newConstraint)
//        self.view.layoutIfNeeded()
        
        //UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut , animations: {
            self.view.removeConstraint(self.topConstraint)
            self.view.addConstraint(newConstraint)
            self.view.layoutIfNeeded()
            //}, completion: { (_) in
                self.style()
        //})
        
        
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func style(){
        
        gradientView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        let blackColor = UIColor(white: 0, alpha: 0.0)
        let clearColor = UIColor(white: 0, alpha: 1.0)
        
        gradientLayer.colors = [blackColor.CGColor, clearColor.CGColor]
        
        gradientLayer.startPoint = CGPointMake(1.0, 0.5)
        gradientLayer.endPoint = CGPointMake(1.0, 1.0)
        gradientView.layer.mask = gradientLayer
    }
    
}

private extension WeatherViewController{
    func renderSubviews() {
        currentWeatherView.render()
        
        daysForecastView.render()
        
    }
}


