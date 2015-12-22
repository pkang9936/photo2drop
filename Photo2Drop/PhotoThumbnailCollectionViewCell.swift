//
//  PhotoThumbnailCollectionViewCell.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 11/17/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class PhotoThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    var photo: PhotoInfo! {
        didSet {
            self.imgView.image = photo.image
        }
    }
    }
