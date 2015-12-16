//
//  SplashScreenViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/16/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import Photos

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var activityIcon: UIActivityIndicatorView!
    @IBOutlet weak var requestBtn: UIButton!
    
    @IBOutlet weak var accessLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.determineStatus() {
            
        } else {
            accessLabel.text = "This App need access to use your Photo Library"
            requestBtn.hidden = false
        }
        activityIcon.hidden = true
    }
    
    private func determineStatus() -> Bool {
        /*
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .Authorized:
            return true
        case .NotDetermined:
            PHPhotoLibrary.requestAuthorization({ _ in            })
            return false
        case .Restricted:
            return false
        case .Denied:
            let alert = UIAlertController(title: "Need Authorization", message: "Wouldn't you like to authorize this app to use your Photo library?", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in
                let url = NSURL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.sharedApplication().openURL(url)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
            
        }
*/
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .Authorized:
            return true
        case .NotDetermined:
            return false
        case .Restricted:
            return false
        case .Denied:
            return false
            
        }
    }
    

    @IBAction func rquestAccess(sender: AnyObject) {
        PHPhotoLibrary.requestAuthorization({ _ in            })
    }

}
