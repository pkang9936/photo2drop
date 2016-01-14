//
//  ScannerDetailViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 1/14/16.
//  Copyright © 2016 Kang, Puthyrak. All rights reserved.
//

import UIKit

class ScannerDetailViewController: UIViewController {

    @IBOutlet weak var viewSelector: UISegmentedControl!
    @IBOutlet weak var amazonView: UIView!
    @IBOutlet weak var reviewView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didOptionSelected(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.amazonView.hidden = false
            self.reviewView.hidden = true
        case 1:
            self.amazonView.hidden = true
            self.reviewView.hidden = false
        default:
            break;
            
        }
    }
}
