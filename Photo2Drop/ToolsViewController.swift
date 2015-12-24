//
//  ToolsViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/24/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class ToolsViewController: SWFrontViewController {

    @IBOutlet weak var temperatureSetting: UISegmentedControl!
    
    @IBOutlet weak var convertedTemperature: UILabel!
    
    
    @IBOutlet weak var temperatureText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.temperatureSetting.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func converTemperature(sender: AnyObject) {
        switch self.temperatureSetting.selectedSegmentIndex {
        case 0:
            print("C is selected")
            
            let fah: Double = (9 * Double(temperatureText.text!)! + 160) / 5
            
            self.convertedTemperature.text = "\(fah)"
        case 1:
            print("F is selected")
            let cel: Double = (Double(temperatureText.text!)! - 32) * 5/9
            self.convertedTemperature.text = "\(cel)"
        default:
            break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
