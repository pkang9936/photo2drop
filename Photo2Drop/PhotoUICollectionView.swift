//
//  PhotoUICollectionView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/22/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class PhotoUICollectionView: UICollectionView {
    
    var photos: [PhotoInfo]? {
        didSet{
            self.delegate = self
            self.dataSource = self
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.reloadData()
    }

}

extension PhotoUICollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = photos?.count else {return 0}
        return count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.PhotoThumbnailCellIdentifer, forIndexPath: indexPath) as! PhotoThumbnailCollectionViewCell
        cell.photo = photos?[indexPath.row]
        return cell
    }
   
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension PhotoUICollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        if traitCollection.verticalSizeClass == .Compact {
            return CGSize(width: screenWidth/7 - 1  , height: screenWidth/7 - 1);

        }
        return CGSize(width: screenWidth/4 - 1  , height: screenWidth/4 - 1);
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 1.0
    }
    //
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //
    //    }
    //
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    //        
    //    }
}
