//
//  HomeViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/1/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import Photos

class HomeViewController: SWFrontViewController {

    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    @IBOutlet weak var photoBackgroundView: UIView!
    // MARK: - UICollecitonViewDataSource
    private var albums = [PhotoAlbumInfo]()
    private var albumHandler = GetAlbumHandler()
    private var photos = [PhotoInfo]()
    
    @IBOutlet weak var photoThumbnailCollectionView: UICollectionView!
    
    private var sizeClass: UIUserInterfaceSizeClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumHandler.delegate = self
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if let layout = albumCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            if traitCollection.verticalSizeClass == .Compact {
                layout.scrollDirection = .Vertical
                self.sizeClass = .Compact
            }else {
                layout.scrollDirection = .Horizontal
                self.sizeClass = .Regular
            }
            self.photoThumbnailCollectionView.reloadData()
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        albumHandler.getAllAlbums()
        albumCollectionView.reloadData()
        photoThumbnailCollectionView.reloadData()

        
        
    }
      
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.albumCollectionView {
            return self.albums.count
        }
        return photos.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.albumCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.AlbumCellIdentifier, forIndexPath: indexPath) as! AlbumCollectionViewCell
            
            cell.album = albums[indexPath.row]
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.PhotoThumbnailCellIdentifer, forIndexPath: indexPath) as! PhotoThumbnailCollectionViewCell
        cell.photo = photos[indexPath.row]
        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == self.albumCollectionView {
            
            for cell in collectionView.visibleCells() as! [AlbumCollectionViewCell] {
                cell.removeHighlight()
            }
            
            
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! AlbumCollectionViewCell
            cell.highlight()
            let currAlbum = albums[indexPath.row]
            albumHandler.getPhotosForAlbum(albumInfo: currAlbum)
            photoThumbnailCollectionView.reloadData()
            
            
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == self.albumCollectionView {
            return CGSize(width: 70.0  , height: 70.0);

        }
        
        let screenWidth = collectionView.bounds.width //UIScreen.mainScreen().bounds.width
        //let screenHeight = UIScreen.mainScreen().bounds.height
        
        if let sizeClass = self.sizeClass {
            if sizeClass == .Compact {
                return CGSize(width: screenWidth/6  , height: screenWidth/6);
            }
        }
        return CGSize(width: screenWidth/4  , height: screenWidth/4);

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0.0
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

extension HomeViewController: GetAlbumHandlerDelegate {
    func didGetAlbums(albums: [PhotoAlbumInfo]) {
        self.albums = albums
        
    }
    
    func didGetPhotosForAlbum(photos : [PhotoInfo]) {
        self.photos = photos
    }
}


