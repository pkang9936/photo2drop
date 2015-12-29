
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
    private var viewConstraints = Array<NSLayoutConstraint>()
    
   // var viewDics = [String : AnyObject]()
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
        self.backgroundColor = UIColor.clearColor()
        layoutToTop(forecastCells.first!)
        for cell in forecastCells {
            cell.translatesAutoresizingMaskIntoConstraints = false
            let heightContraints = NSLayoutConstraint(item: cell, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 50)
            self.viewConstraints.append(heightContraints)
           // NSLayoutConstraint.activateConstraints([heightContraints])
            
//           // cell.setHeight(50.0)
//            
//            let view1_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
//                "V:[cell\(index)(30)]",
//                options: NSLayoutFormatOptions(rawValue:0),
//                metrics: nil, views: viewDics)
//            cell.addConstraints(view1_constraint_V)
//            index += 1
        }
        
        for idx in 1..<forecastCells.count {
            let previousCell = forecastCells[idx-1]
            let cell = forecastCells[idx]
            layoutViewsVertically(cell, view2: previousCell)
           
            
        }
        for cell in forecastCells {
            layoutToLeft(cell)
            layoutToRight(cell)
        }

        //layoutToBottom(forecastCells.last!)
        
        NSLayoutConstraint.activateConstraints(self.viewConstraints)
    }
    
    func layoutToTop(view: UIView) {
//                let newConstraint = NSLayoutConstraint(
//            item: view,
//            attribute: .TopMargin,
//            relatedBy: .Equal,
//            toItem: view.superview,
//            attribute: .Top,
//            multiplier: 1.0,
//            constant: 0.0)
//        
//        view.superview!.addConstraint(newConstraint)
//        view.superview!.layoutIfNeeded()
//        //print("\ncell to top:bound:[x=\(view.frame.origin.x),y=\(view.frame.origin.y)")
        
        let pinTop = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal,
            toItem: view.superview, attribute: .Top, multiplier: 1.0, constant: 0.0)
        self.viewConstraints.append(pinTop)
        
    }
    
    func layoutToBottom(view: UIView) {
        
        let newConstraint = NSLayoutConstraint(
            item: view,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view.superview,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 35.0)
        
        view.superview!.addConstraint(newConstraint)
        view.superview!.layoutIfNeeded()
    }
    
    func layoutToLeft(view: UIView) {
        
//        let newConstraint = NSLayoutConstraint(
//            item: view,
//            attribute: .Leading,
//            relatedBy: .Equal,
//            toItem: view.superview,
//            attribute: .Leading,
//            multiplier: 1.0,
//            constant: 30.0)
//        
//        view.superview!.addConstraint(newConstraint)
//        view.superview!.layoutIfNeeded()
        let horizonalContraints = NSLayoutConstraint(item: view, attribute:
            .LeadingMargin, relatedBy: .Equal, toItem: view.superview,
            attribute: .LeadingMargin, multiplier: 1.0,
            constant: 0.0)
        self.viewConstraints.append(horizonalContraints)
        
    }
    
    
    func layoutToRight(view: UIView) {
//        let newConstraint = NSLayoutConstraint(
//            item: view,
//            attribute: .Trailing,
//            relatedBy: .Equal,
//            toItem: view.superview,
//            attribute: .Trailing,
//            multiplier: 1.0,
//            constant: 0.0)
//        
//        view.superview!.addConstraint(newConstraint)
//        view.superview!.layoutIfNeeded()
        
        let rightContraints = NSLayoutConstraint(item: view, attribute:
            .TrailingMargin, relatedBy: .Equal, toItem: view.superview,
            attribute: .TrailingMargin, multiplier: 1.0, constant: 0.0)
        self.viewConstraints.append(rightContraints)
        
    }
    
    func layoutViewsVertically(view1: UIView, view2: UIView) {
        
        
        
//        let newConstraint = NSLayoutConstraint(
//            item: view1,
//            attribute: .Top,
//            relatedBy: .Equal,
//            toItem: view2,
//            attribute: .Bottom,
//            multiplier: 1.0,
//            constant: 20.0)
//        
//        view1.superview!.addConstraint(newConstraint)
//        view1.superview!.layoutIfNeeded()
        let pinTop2 = NSLayoutConstraint(item: view1, attribute: .Top, relatedBy: .Equal,
            toItem: view2, attribute: .BottomMargin, multiplier: 1.0, constant: 0.0)
        self.viewConstraints.append(pinTop2)
        
    }
    
    func render() {
        
    }

}
