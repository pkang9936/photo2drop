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
        
        //albums = PhotoAlbumInfo.createPhotoAlbums()
        albumHandler.delegate = self
       
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /*
        * Check the authorization status every time the root view controller appears and whenever the app is brought to the foreground
        */
        if self.determineStatus() {
            albumHandler.getAllAlbums()
            albumCollectionView.reloadData()
            photoThumbnailCollectionView.reloadData()
            
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "determineStatus", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
    }
    
    private func determineStatus() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .Authorized:
            return true
        case .NotDetermined:
            PHPhotoLibrary.requestAuthorization({ _ in            })
            return false
        case .Restricted:
            return false
        case .Denied:
            let alert = UIAlertController(title: "Need Authorization", message: "Wouldn't you like to authorize this app to use your Photo library?", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in
                let url = NSURL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.sharedApplication().openURL(url)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
            
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

extension HomeViewController: GetAlbumHandlerDelegate {
    func didGetAlbums(albums: [PhotoAlbumInfo]) {
        self.albums = albums
        
    }
    
    func didGetPhotosForAlbum(photos : [PhotoInfo]) {
        self.photos = photos
    }
}


