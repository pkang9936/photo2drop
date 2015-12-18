//
//  SplashScreenViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/16/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import Photos 

class SplashScreenViewController: UIViewController{

    @IBOutlet weak var activityIcon: UIActivityIndicatorView!
    
    @IBOutlet weak var accessLabel: UILabel!
    
    // MARK - Authorization to photo album
    private var photoAlbumHandler: GetAuthorizationToUsePhotoAlbumHandler!
    private var actionSheet: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.photoAlbumHandler = GetAuthorizationToUsePhotoAlbumHandler()
        self.photoAlbumHandler.delegate = self
        self.photoAlbumHandler.checkAuthorizationToUsePhotoAlbum()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.photoAlbumHandler.checkAuthorizationToUsePhotoAlbum()
        self.activityIcon.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "determineStatus", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
    }
    
    func determineStatus() {
        photoAlbumHandler.checkAuthorizationToUsePhotoAlbum()
    }
    
//    private func determineStatus() -> Bool {
//        /*
//        let status = PHPhotoLibrary.authorizationStatus()
//        switch status {
//        case .Authorized:
//            return true
//        case .NotDetermined:
//            PHPhotoLibrary.requestAuthorization({ _ in            })
//            return false
//        case .Restricted:
//            return false
//        case .Denied:
//            let alert = UIAlertController(title: "Need Authorization", message: "Wouldn't you like to authorize this app to use your Photo library?", preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
//            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in
//                let url = NSURL(string: UIApplicationOpenSettingsURLString)!
//                UIApplication.sharedApplication().openURL(url)
//            }))
//            self.presentViewController(alert, animated: true, completion: nil)
//            return false
//            
//        }
//*/
//        let status = PHPhotoLibrary.authorizationStatus()
//        switch status {
//        case .Authorized:
//            return true
//        case .NotDetermined:
//            return false
//        case .Restricted:
//            return false
//        case .Denied:
//            return false
//            
//        }
//    }
    
    //self.navigationController?.popToRootViewControllerAnimated(true)
   

    @IBAction func appActionSheet(sender: AnyObject) {
        
        //topule
        //need information about the status and
        //need to return tupple
        
        self.actionSheet = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .ActionSheet)
//        let requestAccessBtn = UIAlertAction(title: "Request Authorization", style: .Default) { (authSelected) -> Void in
//            self.photoAlbumHandler.requestAuthorization()
//        }
        
//        let quitAppBtn = UIAlertAction(title: "Quit App", style: .Default) { (_) -> Void in
//            ExitAppHandler.quitApp()
//        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let margin:CGFloat = 8.0
        let rect = CGRectMake(margin, margin, self.actionSheet.view.bounds.size.width - margin * 4.0, 300.0)
        //var customView = UIView(frame: rect)
        let customView = ActionsheetView.loadNib()
        customView.frame = rect
        customView.delegate = self
        
        customView.backgroundColor = UIColor.clearColor()
        self.actionSheet.view.addSubview(customView)

        
        //actionSheet.addAction(requestAccessBtn)
        //actionSheet.addAction(quitAppBtn)
        self.actionSheet.addAction(cancelBtn)

        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
}

extension SplashScreenViewController: GetAuthorizationToUsePhotoAlbumHandlerDelegate {
    func didAuthorized() {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.accessLabel.text = "This App is authorized!"
            self.performSegueWithIdentifier(Storyboard.seqMainScreenIdentifier, sender: self)
        }
        
    }
    func didNotDetermined() {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.accessLabel.text = "User did not decide yet"
        }
    }
    func didRestricted() {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.accessLabel.text = "This App has restricted access"
        }
    }
    func didDenied() {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.accessLabel.text = "This App was denied the access!"
        }
    }
}

extension SplashScreenViewController: ActionsheetViewDelegate {
    func didClickOnRequestAuthorization() {
        self.actionSheet.dismissViewControllerAnimated(true, completion: nil)
        self.photoAlbumHandler.requestAuthorization()
    }
    
    func didClickOnSettings() {
        self.actionSheet.dismissViewControllerAnimated(true, completion: nil)
        self.photoAlbumHandler.resetAuthorization()
        
    }
    
    func didClickOnQuitApp() {
        ExitAppHandler.quitApp()
    }

}

