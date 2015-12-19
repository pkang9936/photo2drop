//
//  TouchIDViewController.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/18/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class TouchIDViewController: UIViewController {

    private var authenticate =  TouchIDAuthenticationHandler()
    
    @IBOutlet weak var authenticateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateBtn.layer.cornerRadius = 5.0
        authenticateBtn.layer.borderWidth = 1.0
        authenticateBtn.layer.borderColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1.0).CGColor
        
        authenticate.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "touchIDAuthenticate", name: UIApplicationWillEnterForegroundNotification, object: nil)
        self.touchIDAuthenticate()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        
    }
    
    private func touchIDAuthenticate() {
        authenticate.authenticate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func authenticateWithTouchID(sender: AnyObject) {
        touchIDAuthenticate()
    }

}

extension TouchIDViewController: TouchIDAuthenticationHandlerDelegate {
    func didSuccessfulAuthenticate() {
        NSLog("Yes!")
        dispatch_async(dispatch_get_main_queue()) {
            
            self.performSegueWithIdentifier(Storyboard.segAlbumAuth, sender: self)        }
    }
    func didFailAuthenticate() {
        NSLog("NO!")
    }
    func touchIDAuthenticationNotSupported() {
        NSLog("Not support!")
    }
}
