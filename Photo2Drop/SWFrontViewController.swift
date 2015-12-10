//
//  SWFrontViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/10/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class SWFrontViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            let menuButton = UIBarButtonItem(image: UIImage(named: "reveal-icon"), style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.navigationItem.leftBarButtonItem = menuButton
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }

}
