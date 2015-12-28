
//
//  WeatherDaysForecastView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/25/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class WeatherDaysForecastView: UIView {
    
    private var didSetupConstraints = false
    private var forecastCells = Array<WeatherDayForecastView>()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup () {
        for _ in 0..<7 {
            let cell = WeatherDayForecastView.loadNib()
            self.forecastCells.append(cell)
            self.addSubview(cell)
            
        }
    }
    override func updateConstraints() {
        if didSetupConstraints {
            super.updateConstraints()
            return
        }
        layoutView()
        super.updateConstraints()
        didSetupConstraints = true
    }
    
    
    func layoutView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        layoutToTop(forecastCells.first!)

//        layout(forecastCells.first!) { view in
//            view.top == view.superview!.top
//        }
//        
//        for idx in 1..<forecastCells.count {
//            let previousCell = forecastCells[idx-1]
//            let cell = forecastCells[idx]
//            layout(cell, previousCell) { view, view2 in
//                view.top == view2.bottom
//            }
//        }
        for cell in forecastCells {
            layoutToLeft(cell)
            layoutToRight(cell)
        }
//        layout(forecastCells.last!) { view in
//            view.bottom == view.superview!.bottom
//        }
        layoutToBottom(forecastCells.last!)
    }
    
    func layoutToTop(view: UIView) {
        
        let newConstraint = NSLayoutConstraint(
            item: view,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: view.superview,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0.0)
        
        view.superview!.addConstraint(newConstraint)
        view.superview!.layoutIfNeeded()
    }
    
    func layoutToBottom(view: UIView) {
        let newConstraint = NSLayoutConstraint(
            item: view,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view.superview,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        view.superview!.addConstraint(newConstraint)
        view.superview!.layoutIfNeeded()
    }
    
    func layoutToLeft(view: UIView) {
        
        let newConstraint = NSLayoutConstraint(
            item: view,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: view.superview,
            attribute: .Leading,
            multiplier: 1.0,
            constant: 0.0)
        
        view.superview!.addConstraint(newConstraint)
        view.superview!.layoutIfNeeded()
    }
    
    func layoutToRight(view: UIView) {
        let newConstraint = NSLayoutConstraint(
            item: view,
            attribute: .Trailing,
            relatedBy: .Equal,
            toItem: view.superview,
            attribute: .Trailing,
            multiplier: 1.0,
            constant: 0.0)
        
        view.superview!.addConstraint(newConstraint)
        view.superview!.layoutIfNeeded()
    }
    
    func render() {
        
    }

}
