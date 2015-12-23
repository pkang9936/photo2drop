//
//  AlbumUICollectionView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/22/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

struct Bundle {
    var offset: CGPoint = CGPointZero
    var sourceCell : UICollectionViewCell
    var representationImageView: UIView
    var currentIndexPath: NSIndexPath
}

protocol AlbumUICollectionViewDropDelegate {
    func dropDataItem(bundle: Bundle) -> Void
}

class AlbumUICollectionView: UICollectionView {
    
    var albumDropDelegate: AlbumUICollectionViewDropDelegate?
    
    var photoScrollView: UIView?
    
    var albums: [PhotoAlbumInfo]? {
        didSet {
            self.reloadData()
            self.dataSource = self
        }
    }
    
    var animating: Bool = false
    var canvas: UIView? {
        didSet {
            if canvas != nil {
                self.calculateBorders()
            }
        }
    }
    var collectionViewFrameInCanvas: CGRect = CGRectZero
    var hitTestRectangles = [String:CGRect]()


    
    var bundle: Bundle?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup() {
        if let collectionView = self as UICollectionView! {
            
            let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: "handleGesture:")
            
            longPressGestureRecogniser.minimumPressDuration = 0.2
            longPressGestureRecogniser.delegate = self
            
            collectionView.addGestureRecognizer(longPressGestureRecogniser)
            
            if self.canvas == nil {
                self.canvas = collectionView.superview
            }
        }
    }
    
    // MARK: Helper Methods
    func convertRectToCanvas(rect : CGRect, fromView view : UIView) -> CGRect {
        
        var r : CGRect = rect
        
        var v = view
        
        while v != self.canvas {
            
            if let sv = v.superview {
                
                r.origin.x += sv.frame.origin.x
                r.origin.y += sv.frame.origin.y
                
                v = sv
                
                continue
            }
            break
        }
        
        return r
    }
}

extension AlbumUICollectionView: DragAndDropCollectionViewDataSource {
    
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
        album.indexPath = indexPath
        cell.albumImg.image = album.albumImage
        
        return cell

    }
    
    func collectionView(collectionView: UICollectionView, indexPathForDataItem dataItem: AnyObject) -> NSIndexPath? {
        if let candidate : PhotoAlbumInfo = dataItem as? PhotoAlbumInfo {
            
            for item : PhotoAlbumInfo in albums! {
                if candidate  == item {
                    
                    let position = albums!.indexOf(item)! // ! if we are inside the condition we are guaranteed a position
                    let indexPath = NSIndexPath(forItem: position, inSection: 0)
                    return indexPath
                }
            }
        }
        
        return nil
    }
    func collectionView(collectionView: UICollectionView, dataItemForIndexPath indexPath: NSIndexPath) -> AnyObject {
        return albums![indexPath.item]
    }
    
    func collectionView(collectionView: UICollectionView, moveDataItemFromIndexPath from: NSIndexPath, toIndexPath to : NSIndexPath) -> Void {
        let fromDataItem: PhotoAlbumInfo = albums![from.item]
        albums?.removeAtIndex(from.item)
        albums?.insert(fromDataItem, atIndex: to.item)
    }
    
    func collectionView(collectionView: UICollectionView, insertDataItem dataItem : AnyObject, atIndexPath indexPath: NSIndexPath) -> Void {
        if let di = dataItem as? PhotoAlbumInfo {
            albums!.insert(di, atIndex: indexPath.item)
        }
    }
    func collectionView(collectionView: UICollectionView, deleteDataItemAtIndexPath indexPath: NSIndexPath) -> Void {
        albums!.removeAtIndex(indexPath.item)
    }
    
}

extension AlbumUICollectionView:  UIGestureRecognizerDelegate {
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let ca = self.canvas {
            
            if let cv = self as UICollectionView! {
                
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
    
    func calculateBorders() {
        
        if let collectionview = self as UICollectionView!{
            
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
            
            switch gesture.state {
            case .Began:
                bundle.sourceCell.hidden = true
                self.canvas?.addSubview(bundle.representationImageView)

            case .Changed:
                //Update the representation image
                var imageViewFrame = bundle.representationImageView.frame
                var point = CGPointZero
                point.x = dragPointOnCanvas.x - bundle.offset.x
                point.y = dragPointOnCanvas.y - bundle.offset.y
                imageViewFrame.origin = point
                bundle.representationImageView.frame = imageViewFrame
                
                let dragPointOnCollectionView = gesture.locationInView(self)
                
                if let indexPath: NSIndexPath = self.indexPathForItemAtPoint(dragPointOnCollectionView) {
                    
                    self.checkForDraggingAtTheEdgeAndAnimatePaging(gesture)
                    
                    if indexPath.isEqual(bundle.currentIndexPath) == false {
                        
                        //If we have a collection view controller that implements the delegate we call the method first
                        if let delegate = self.delegate as? RearrangeableCollectionViewDelegate {
                            delegate.moveDataItem(bundle.currentIndexPath, toIndexPath: indexPath)
                        }
                        
                        self.moveItemAtIndexPath(bundle.currentIndexPath, toIndexPath: indexPath)
                        
                        self.bundle?.currentIndexPath = indexPath
                    }
                }
                
                //photo scroll view
                let photoViewFrameOnCanvas = self.convertRectToCanvas(self.photoScrollView!.frame, fromView: self.photoScrollView!)
                
                let intersectionNew = CGRectIntersection(bundle.representationImageView.frame, photoViewFrameOnCanvas).size
                if (intersectionNew.width * intersectionNew.height) > 0.0 {
                    self.photoScrollView!.hidden = false
                    self.photoScrollView!.backgroundColor = UIColor(red: 111.0/255.0, green: 141.0/255.0, blue: 189.0/255.0, alpha: 1.0)
                    
                }else {
                    self.photoScrollView!.backgroundColor = UIColor.clearColor()
                    self.photoScrollView!.hidden = true
                }
                
            case .Ended:
                bundle.sourceCell.hidden = false
                
                if let dragCell = bundle.sourceCell as? RearrangeableCollectionViewCell {
                    dragCell.dragging = false
                }
                
                //photo scroll view
                let photoViewFrameOnCanvas = self.convertRectToCanvas(self.photoScrollView!.frame, fromView: self.photoScrollView!)
                let intersectionNew = CGRectIntersection(bundle.representationImageView.frame, photoViewFrameOnCanvas).size
                if (intersectionNew.width * intersectionNew.height) > 0.0 {
                    self.albumDropDelegate?.dropDataItem(bundle)
                } else {
                    bundle.representationImageView.removeFromSuperview()
                }
                
                
                
               
                
                if let _ = self.delegate as? RearrangeableCollectionViewDelegate {
                    self.reloadData()
                }
//                bundle.representationImageView.removeFromSuperview()
                self.bundle = nil
//                self.photoScrollView!.backgroundColor = UIColor.clearColor()
//                self.photoScrollView!.hidden = true
                
               
            default:
                break
            }
            
        }
    }
    
    func checkForDraggingAtTheEdgeAndAnimatePaging(gesture: UILongPressGestureRecognizer) -> Void {
        
        if self.animating == true {
            return
        }
        
        if let bundle = self.bundle {
            
            var nextPageRect: CGRect = self.bounds
            
            if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
                if layout.scrollDirection == UICollectionViewScrollDirection.Horizontal {
                    if CGRectIntersectsRect(bundle.representationImageView.frame, hitTestRectangles["left"]!) {
                        nextPageRect.origin.x -= nextPageRect.size.width
                        
                        if nextPageRect.origin.x < 0.0 {
                            nextPageRect.origin.x = 0
                        }
                    } else if CGRectIntersectsRect(bundle.representationImageView.frame, hitTestRectangles["right"]!) {
                        
                        nextPageRect.origin.x += nextPageRect.size.width
                        
                        if nextPageRect.origin.x + nextPageRect.size.width > self.contentSize.width {
                            
                            nextPageRect.origin.x = self.contentSize.width - nextPageRect.size.width
                            
                        }
                    }
                }
                
                if !CGRectEqualToRect(nextPageRect, self.bounds) {
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
                        self.animating = false
                        self.handleGesture(gesture)
                    })
                    
                    self.animating = true
                    self.scrollRectToVisible(nextPageRect, animated: true)
                }
            }
            
        }
    }
    
}

