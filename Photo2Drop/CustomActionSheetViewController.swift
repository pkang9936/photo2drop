//
//  CustomActionSheetViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/18/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class CustomActionSheetViewController: UIAlertController {
    var contentView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        guard let contentView = self.contentView else {return}
        let margin:CGFloat = 8.0
        let rect = CGRectMake(margin, margin, self.view.bounds.size.width - margin * 4.0, 300.0)
        contentView.frame = rect
        contentView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(contentView)
    }
    
    func addContentView(contentView: UIView) {
        self.contentView = contentView
    }
}
