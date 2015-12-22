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
            self.delegate = self
            self.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension AlbumUICollectionView: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = albums?.count else { return 0 }
        return count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.AlbumCellIdentifier, forIndexPath: indexPath) as! RearrangeableCollectionViewCell
        let album = albums![indexPath.row] as PhotoAlbumInfo
        cell.albumImg.image = album.albumImage
        
        return cell

    }
}


extension AlbumUICollectionView: UICollectionViewDelegateFlowLayout {
    
}
