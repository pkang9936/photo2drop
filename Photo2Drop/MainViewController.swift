//
//  ViewController.swift
//  TB_TwitterHeader
//
//  Created by Yari D'areglia on 17/01/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

import UIKit

let offset_HeaderStop:CGFloat = 40.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 95.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label

protocol RearrangeableCollectionViewDelegate {
    func moveDataItem(fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath)
}


class MainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var currentAlbumImage:UIImageView!
    @IBOutlet weak var currentAlbumName: UILabel!
    @IBOutlet weak var currentAlbumCount: UILabel!
    
    @IBOutlet var header:UIView!
    @IBOutlet var headerLabel:UILabel!
   
    @IBOutlet weak var leftMenuButton: UIButton!
    
    // MARK - Album colleciton
    @IBOutlet weak var albumCollectionView: UICollectionView!
    private var albums: [PhotoAlbumInfo]?
    private var albumHandler = GetAlbumHandler()
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    // MARK - Dag & Drop helpers
    var dragAndDropManager : DragAndDropManager?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            leftMenuButton.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        scrollView.delegate = self
        
        albumHandler.delegate = self
        albumHandler.getAllAlbums()
        
        //self.dragAndDropManager = DragAndDropManager(canvas: self.view, views: [albumCollectionView])
    }

    override func viewDidAppear(animated: Bool) {
        
        header.clipsToBounds = true
        guard let count = albums?.count else { return }
        
        if count > 0 {
            var selectedIndex = 0
            let indexPaths = self.albumCollectionView.indexPathsForSelectedItems()! as [NSIndexPath]
            
            if indexPaths.count > 0 {
                selectedIndex = indexPaths[0].row
            }
            self.loadCurrentAlbumProfile(albums![selectedIndex])
        }
    }
    
    private func loadCurrentAlbumProfile(currentAlbum: PhotoAlbumInfo) {
        albumHandler.getPhotosForAlbum(albumInfo: currentAlbum)
        currentAlbumImage.image = currentAlbum.albumImage
        currentAlbumName.text = currentAlbum.title
        currentAlbumCount.text = "\(currentAlbum.photos.count)"
        headerLabel.text = currentAlbum.title
//        
//        (albumCollectionView as? AlbumUICollectionView)!.albums?.removeAtIndex(currentAlbum.indexPath!.row)
//        self.albumCollectionView.deleteItemsAtIndexPaths([currentAlbum.indexPath!])
       // self.albumCollectionView.reloadData()

    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
        }
        
        // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------

            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            //  ------------ Blur
            
           // headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)

            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / currentAlbumImage.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((currentAlbumImage.bounds.height * (1.0 + avatarScaleFactor)) - currentAlbumImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if currentAlbumImage.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
                
            }else {
                if currentAlbumImage.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        currentAlbumImage.layer.transform = avatarTransform
    }
    @IBAction func uploadToDropbox(sender: AnyObject) {
        let dropboxActionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        dropboxActionsheet.addAction(UIAlertAction(title: "Upload to Dropbox", style: .Default, handler: { _ in
            NSLog("Upload to dropbox")
        }))
        dropboxActionsheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(dropboxActionsheet, animated: true, completion: nil)
    }
}


extension MainViewController: GetAlbumHandlerDelegate {
    func didGetAlbums(albums: [PhotoAlbumInfo]) {
        self.albums = albums
        if let albumController = self.albumCollectionView as? AlbumUICollectionView{
            albumController.albums = albums
        }
        
    }
    
    func didGetPhotosForAlbum(photos : [PhotoInfo]) {
        if let photoController = self.photoCollectionView as? PhotoUICollectionView {
            photoController.photos = photos
        }
    }
}

