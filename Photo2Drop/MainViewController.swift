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
    
    
    
    
    // MARK - Rearrange viewcell
   
    var animating: Bool = false
    var canvas: UIView? {
        didSet {
            if canvas != nil {
                self.calculateBorders()
            }
        }
    }
    
    // MARK - Album colleciton
    @IBOutlet weak var albumCollectionView: UICollectionView!
    private var albums = [PhotoAlbumInfo]()
    private var albumHandler = GetAlbumHandler()
    private var photos = [PhotoInfo]()
    private var currentAlbum: PhotoAlbumInfo?
    
    var collectionViewFrameInCanvas: CGRect = CGRectZero
    var hitTestRectangles = [String:CGRect]()
    
    struct Bundle {
        var offset: CGPoint = CGPointZero
        var sourceCell : UICollectionViewCell
        var representationImageView: UIView
        var currentIndexPath: NSIndexPath
    }
    
    var bundle: Bundle?
    
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
        
        self.setup()
        
         albumHandler.delegate = self
        albumHandler.getAllAlbums()
    }

    override func viewDidAppear(animated: Bool) {
        
        header.clipsToBounds = true
        
        
        albumCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func shamelessActionThatBringsYouToMyTwitterProfile() {
        
        if !UIApplication.sharedApplication().openURL(NSURL(string:"twitter://user?screen_name=bitwaker")!){
            UIApplication.sharedApplication().openURL(NSURL(string:"https://twitter.com/bitwaker")!)
        }
    }
    
    // MARK - helping method to rearrange album celeection cell
    func setup() {
        if let collectionView = self.albumCollectionView {
            
            let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: "handleGesture:")
            
            longPressGestureRecogniser.minimumPressDuration = 0.2
            longPressGestureRecogniser.delegate = self
            
            collectionView.addGestureRecognizer(longPressGestureRecogniser)
            
            if self.canvas == nil {
                self.canvas = collectionView.superview
            }
        }
    }
    
    
    private func calculateBorders() {
        
        if let collectionview = self.albumCollectionView {
            
            collectionViewFrameInCanvas = collectionview.frame
            
            if self.canvas != collectionview.superview {
                collectionViewFrameInCanvas = self.canvas!.convertRect(collectionViewFrameInCanvas, fromView: collectionview)
            }
            
            var leftRect: CGRect = collectionViewFrameInCanvas
            leftRect.size.width = 20.0
            hitTestRectangles["left"] = leftRect
            
            var topRect: CGRect = collectionViewFrameInCanvas
            topRect.size.height = 20.0
            hitTestRectangles["top"] = topRect
            
            var rightRect: CGRect = collectionViewFrameInCanvas
            rightRect.origin.x = rightRect.size.width - 20.0
            rightRect.size.width = 20.0
            hitTestRectangles["right"] = rightRect
            
            var bottomRect : CGRect = collectionViewFrameInCanvas
            bottomRect.origin.y = bottomRect.origin.y + rightRect.size.height - 20.0
            bottomRect.size.height = 20.0
            hitTestRectangles["bottom"] = bottomRect
            
        }
    }
    
    func handleGesture(gesture: UILongPressGestureRecognizer) -> Void {
        
        if let bundle = self.bundle {
            
            let dragPointOnCanvas = gesture.locationInView(self.canvas)
            
            if gesture.state == UIGestureRecognizerState.Began {
                bundle.sourceCell.hidden = true
                self.canvas?.addSubview(bundle.representationImageView)
            }
            
            if gesture.state == UIGestureRecognizerState.Changed {
                
                //Update the representation image
                var imageViewFrame = bundle.representationImageView.frame
                var point = CGPointZero
                point.x = dragPointOnCanvas.x - bundle.offset.x
                point.y = dragPointOnCanvas.y - bundle.offset.y
                imageViewFrame.origin = point
                bundle.representationImageView.frame = imageViewFrame
                
                let dragPointOnCollectionView = gesture.locationInView(self.albumCollectionView)
                
                if let indexPath: NSIndexPath = self.albumCollectionView.indexPathForItemAtPoint(dragPointOnCollectionView) {
                    
                    self.checkForDraggingAtTheEdgeAndAnimatePaging(gesture)
                    
                    if indexPath.isEqual(bundle.currentIndexPath) == false {
                        
                        //If we have a collection view controller that implements the delegate we call the method first
                        if let delegate = self.albumCollectionView.delegate as? RearrangeableCollectionViewDelegate {
                            delegate.moveDataItem(bundle.currentIndexPath, toIndexPath: indexPath)
                        }
                        
                        self.albumCollectionView.moveItemAtIndexPath(bundle.currentIndexPath, toIndexPath: indexPath)
                        
                        self.bundle?.currentIndexPath = indexPath
                    }
                }
                
            }
            
            if gesture.state == UIGestureRecognizerState.Ended {
                
                bundle.sourceCell.hidden = false
                
                if let dragCell = bundle.sourceCell as? RearrangeableCollectionViewCell {
                    dragCell.dragging = false
                }
                
                bundle.representationImageView.removeFromSuperview()
                
                if let _ = self.albumCollectionView.delegate as? RearrangeableCollectionViewDelegate {
                    self.albumCollectionView.reloadData()
                }
                
                self.bundle = nil
            }
        }
    }
    
    func checkForDraggingAtTheEdgeAndAnimatePaging(gesture: UILongPressGestureRecognizer) -> Void {
     
        if self.animating == true {
            return
        }
        
        if let bundle = self.bundle {
            
            var nextPageRect: CGRect = self.albumCollectionView.bounds
            
            if let layout = self.albumCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                if layout.scrollDirection == UICollectionViewScrollDirection.Horizontal {
                    if CGRectIntersectsRect(bundle.representationImageView.frame, hitTestRectangles["left"]!) {
                        nextPageRect.origin.x -= nextPageRect.size.width
                        
                        if nextPageRect.origin.x < 0.0 {
                            nextPageRect.origin.x = 0
                        }
                    } else if CGRectIntersectsRect(bundle.representationImageView.frame, hitTestRectangles["right"]!) {
                        
                        nextPageRect.origin.x += nextPageRect.size.width
                        
                        if nextPageRect.origin.x + nextPageRect.size.width > albumCollectionView.contentSize.width {
                            
                            nextPageRect.origin.x = albumCollectionView.contentSize.width - nextPageRect.size.width
                            
                        }
                    }
                }
                
                if !CGRectEqualToRect(nextPageRect, albumCollectionView.bounds) {
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
                        self.animating = false
                        self.handleGesture(gesture)
                    })
                    
                    self.animating = true
                    self.albumCollectionView.scrollRectToVisible(nextPageRect, animated: true)
                }
            }
            
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return albums.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.albumCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.AlbumCellIdentifier, forIndexPath: indexPath) as! RearrangeableCollectionViewCell
            let album = albums[indexPath.row] as PhotoAlbumInfo
            cell.albumImg.image = album.albumImage
            
            if indexPath.row == 0 {
                //current album
                self.currentAlbum = album
                
                self.albumHandler.getPhotosForAlbum(albumInfo: self.currentAlbum)
                
                self.currentAlbumImage.image = album.albumImage
                self.currentAlbumName.text = self.currentAlbum?.title
                let count = self.currentAlbum?.photos.count as Int!
                self.currentAlbumCount.text = "\(count)"
                
            }

            
            
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.DummyCellIdentifier, forIndexPath: indexPath)
        
       
        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}



extension MainViewController:  UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let ca = self.canvas {
            
            if let cv = self.albumCollectionView {
                
                let pointPressedInCanvas = gestureRecognizer.locationInView(ca)
                
                for cell in cv.visibleCells() {
                    
                    let cellInCanvasFrame = ca.convertRect(cell.frame, fromView: cv)
                    
                    if CGRectContainsPoint(cellInCanvasFrame, pointPressedInCanvas) {
                        
                        // apply any transformation to the cell
                        
                        if let dragCell = cell as? RearrangeableCollectionViewCell {
                            dragCell.dragging = true
                            
                            let representationImage = cell.snapshotViewAfterScreenUpdates(true)
                            representationImage.frame = cellInCanvasFrame
                            representationImage.frame.size.width = representationImage.frame.size.width + 8
                            representationImage.frame.size.height = representationImage.frame.size.height  + 8
                            var newOrigin = representationImage.frame.origin
                            newOrigin.x = newOrigin.x - 4
                            newOrigin.y = newOrigin.y - 4
                            representationImage.frame.origin = newOrigin
                            
                            
                            let offset = CGPointMake(pointPressedInCanvas.x - cellInCanvasFrame.origin.x, pointPressedInCanvas.y - cellInCanvasFrame.origin.y)
                            
                            let indexPath: NSIndexPath = cv.indexPathForCell(cell as UICollectionViewCell)!
                            
                            self.bundle = Bundle(offset: offset, sourceCell: cell, representationImageView: representationImage, currentIndexPath: indexPath)
                            
                            break
                            
                        }
                    }
                }
            }
        }
        return self.bundle != nil
    }
    
}


extension MainViewController: GetAlbumHandlerDelegate {
    func didGetAlbums(albums: [PhotoAlbumInfo]) {
        self.albums = albums
        
//        if albums.count > 0 {
//            //current album
//            self.currentAlbum = albums[0]
//            
//            self.albumHandler.getPhotosForAlbum(albumInfo: self.currentAlbum)
//            
//            self.currentAlbumImage.image = UIImage(named: "_2") //self.currentAlbum?.albumImage
//            self.currentAlbumName.text = self.currentAlbum?.title
//            let count = self.currentAlbum?.photos.count as Int!
//            self.currentAlbumCount.text = "\(count)"
//        }
        
    }
    
    func didGetPhotosForAlbum(photos : [PhotoInfo]) {
        self.photos = photos
    }
}

