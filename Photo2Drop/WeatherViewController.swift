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
    
}
// MARK: Setup
private extension WeatherViewController {
    func setup() {
        backgroundView.contentMode = .ScaleAspectFill
        backgroundView.clipsToBounds = true
        view.addSubview(backgroundView)
    }
}

// MARK: Layout
extension WeatherViewController {
    func layoutView() {
        
    }
}

private extension WeatherViewController {
    func render(image: UIImage?) {
        if let image = image {
            backgroundView.image = image
        }
    }
}

private extension WeatherViewController {
    func style() {
        
    }
}
