//
//  ActionseetTableViewTableViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/17/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

public protocol ActionsheetViewDelegate {
    func didClickOnRequestAuthorization()
    
    func didClickOnSettings()
    
    func didClickOnQuitApp()
}

class ActionsheetView: UIView {
    
    var delegate: ActionsheetViewDelegate!
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var requestAuthBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var quitBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusLbl.text = "Photo2Drop needs access to your photo albums. It provides abilities to upload the photos to dropbox accounts."
        
        requestAuthBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        requestAuthBtn.addTarget(self, action: "requestAuthorization:", forControlEvents: .TouchUpInside)
        
        
        settingsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        settingsBtn.addTarget(self, action: "settings:", forControlEvents: .TouchUpInside)
        
        quitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        quitBtn.addTarget(self, action: "quitApp:", forControlEvents: .TouchUpInside)
    }
    
    func requestAuthorization(sender: AnyObject) {
        self.delegate.didClickOnRequestAuthorization()
    }
    
    func settings(sender: AnyObject) {
        self.delegate.didClickOnSettings()
    }
    
    func quitApp (sender: AnyObject) {
        self.delegate.didClickOnQuitApp()
    }
}
