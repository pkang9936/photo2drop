//
//  PhotoInfo.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/3/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import UIKit

class PhotoInfo {
    var date: String = ""
    var location: String = ""
    var image: UIImage!
    
    init( date: String, location: String, img: UIImage!) {
        self.date = date
        self.location = location
        self.image = img
    }
}