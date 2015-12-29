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
    
    @IBOutlet weak var overlayView: UIImageView!
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    private var locationDatastore: LocationDatastore?
    
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
        
        
        //
//        overlayView.contentMode = .ScaleAspectFill
//        overlayView.clipsToBounds = true
//        
//        view.addSubview(overlayView)
        
        scrollView.delegate = self
        
        overlayView.image = UIImage(named: "DefaultImage")?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        overlayView.alpha = 0
        
        let lat: Double = 48.8567
        let lon: Double = 2.3508
        FlickrDatastore().retrieveImageAtLat(lat,lon: lon) {
            image in
            self.render(image)
        }
        
//        locationDatastore = LocationDatastore() { [weak self] location in
//            
//            FlickrDatastore().retrieveImageAtLat(location.lat, lon: location.lon)
//                { (image) -> Void in
//                    self?.render(image)
//                    return
//                }
//        }
        
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
    
    func render(image: UIImage?){
        if let image = image {
            backgroundView.image = image
            print("Image updated backgroundView.frame (w=\(backgroundView.frame .size.width)")
            overlayView.image = image.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
            overlayView.alpha = 0
        }
    }
    
}

private extension WeatherViewController{
    func renderSubviews() {
        currentWeatherView.render()
        
        daysForecastView.render()
        
    }
}

// MARK: UIScrollViewDelegate
extension WeatherViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let treshold: CGFloat = CGFloat(view.frame.height)/2
        overlayView.alpha = min (1.0, offset/treshold)
        
    }
}

