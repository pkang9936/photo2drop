//
//  AlbumUICollectionView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/22/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class AlbumUICollectionView: UICollectionView {
    
    var albums: [PhotoAlbumInfo]? {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
