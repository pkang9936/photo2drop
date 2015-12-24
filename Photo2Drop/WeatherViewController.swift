//
//  WeatherViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/24/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import Cartography

class WeatherViewController: UIViewController {
    
    private let backgroundView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layoutView()
        style()
        render(UIImage(named: "DefaultImage"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
