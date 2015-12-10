//
//  SimpleViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 11/20/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {

    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //img2.didChangeRoundCorner()
        //img3.didChangeRoundCorner()
        //img4.didChangeRoundCorner()
    }

}
