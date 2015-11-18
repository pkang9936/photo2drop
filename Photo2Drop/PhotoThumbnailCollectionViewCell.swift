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
    
    func setThumbnailImage(thumbnailImage: UIImage) {
        imgView.image = thumbnailImage
    }
}
