//
//  HomeViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/1/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class HomeViewController: SWFrontViewController {

    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    @IBOutlet weak var photoBackgroundView: UIView!
    // MARK: - UICollecitonViewDataSource
    private var albums: [PhotoAlbum]!
    private var currentAlbum: PhotoAlbum!
    
    @IBOutlet weak var photoThumbnailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
*/
        
        albumCollectionView.backgroundColor = UIColor.grayColor()
        
        //photoBackgroundView.layer.borderColor = UIColor.blueColor().CGColor
        //photoBackgroundView.layer.borderWidth = 1.0
        
        albums = PhotoAlbum.createPhotoAlbums()
        currentAlbum = albums[0]
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if let layout = albumCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            
            if traitCollection.verticalSizeClass == .Compact {
                layout.scrollDirection = .Vertical
            }else {
                layout.scrollDirection = .Horizontal
            }
        }
        
    }

    private struct Storyboard {
        static let AlbumCellIdentifier = "Album Cell"
        static let PhotoThumbnailCellIdentifer = "Photo Cell"
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.albumCollectionView {
            return self.albums.count
        }
        return self.currentAlbum.photos.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.albumCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.AlbumCellIdentifier, forIndexPath: indexPath) as! AlbumCollectionViewCell
            
            cell.album = albums[indexPath.row]
            
            if indexPath.row == 1 {
                cell.highlight()
            }
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.PhotoThumbnailCellIdentifer, forIndexPath: indexPath) as! PhotoThumbnailCollectionViewCell
        
        let photos = currentAlbum.photos
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
            currentAlbum = albums[indexPath.row]
            photoThumbnailCollectionView.reloadData()
            
            
        }
    }
    
}




