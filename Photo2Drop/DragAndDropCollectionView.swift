//
//  DragAndDropCollectionView.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/22/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

@objc protocol DragAndDropCollectionViewDataSource : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, indexPathForDataItem dataItem: AnyObject) -> NSIndexPath?
    func collectionView(collectionView: UICollectionView, dataItemForIndexPath indexPath: NSIndexPath) -> AnyObject
    
    func collectionView(collectionView: UICollectionView, moveDataItemFromIndexPath from: NSIndexPath, toIndexPath to : NSIndexPath) -> Void
    func collectionView(collectionView: UICollectionView, insertDataItem dataItem : AnyObject, atIndexPath indexPath: NSIndexPath) -> Void
    func collectionView(collectionView: UICollectionView, deleteDataItemAtIndexPath indexPath: NSIndexPath) -> Void
    
}


class DragAndDropCollectionView: UICollectionView{

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var draggingPathOfCellBeingDragged: NSIndexPath?
    
    var iDataSource: UICollectionViewDataSource?
    var iDelegate: UICollectionViewDelegate?
    
    
    private var currentInRect : CGRect?
    var paging : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    func indexPathForCellOverlappingRect( rect : CGRect) -> NSIndexPath? {
        
        var overlappingArea : CGFloat = 0.0
        var cellCandidate : UICollectionViewCell?
        
        
        let visibleCells = self.visibleCells()
        if visibleCells.count == 0
        {
            return NSIndexPath(forRow: 0, inSection: 0)
        }
        
        for visible in visibleCells {
            
            let intersection = CGRectIntersection(visible.frame, rect)
            
            if (intersection.width * intersection.height) > overlappingArea {
                
                overlappingArea = intersection.width * intersection.width
                
                cellCandidate = visible
            }
            
        }
        
        if let cellRetrieved = cellCandidate {
            
            return self.indexPathForCell(cellRetrieved)
        }
        
        return nil
    }

    func checkForEdgesAndScroll(rect : CGRect) -> Void {
        
        if paging == true {
            return
        }
        
        let currentRect : CGRect = CGRect(x: self.contentOffset.x, y: self.contentOffset.y, width: self.bounds.size.width, height: self.bounds.size.height)
        var rectForNextScroll : CGRect = currentRect
        
        if (self.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .Horizontal {
            
            let leftBoundary = CGRect(x: -30.0, y: 0.0, width: 30.0, height: self.frame.size.height)
            let rightBoundary = CGRect(x: self.frame.size.width, y: 0.0, width: 30.0, height: self.frame.size.height)
            
            if CGRectIntersectsRect(rect, leftBoundary) == true {
                rectForNextScroll.origin.x -= self.bounds.size.width
                if rectForNextScroll.origin.x < 0 {
                    rectForNextScroll.origin.x = 0
                }
            }
            else if CGRectIntersectsRect(rect, rightBoundary) == true {
                rectForNextScroll.origin.x += self.bounds.size.width
                if rectForNextScroll.origin.x > self.contentSize.width - self.bounds.size.width {
                    rectForNextScroll.origin.x = self.contentSize.width - self.bounds.size.width
                }
            }
            
        }
        else if (self.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection == .Vertical {
            
            let topBoundary = CGRect(x: 0.0, y: -30.0, width: self.frame.size.width, height: 30.0)
            let bottomBoundary = CGRect(x: 0.0, y: self.frame.size.height, width: self.frame.size.width, height: 30.0)
            
            if CGRectIntersectsRect(rect, topBoundary) == true {
                
            }
            else if CGRectIntersectsRect(rect, bottomBoundary) == true {
                
            }
        }
        
        // check to see if a change in rectForNextScroll has been made
        if CGRectEqualToRect(currentRect, rectForNextScroll) == false {
            self.paging = true
            self.scrollRectToVisible(rectForNextScroll, animated: true)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.paging = false
            }
            
        }
        
    }
}

extension DragAndDropCollectionView: Draggable {
    func canDragAtPoint(point: CGPoint) -> Bool {
        return self.dataSource != nil && self.dataSource is DragAndDropCollectionViewDataSource && self.indexPathForItemAtPoint(point) != nil
    }
    func representationImageAtPoint(point: CGPoint) -> UIView? {
        
        var imageView: UIView?
        
        if let indexPath = self.indexPathForItemAtPoint(point) {
            
            let cell = self.cellForItemAtIndexPath(indexPath)!
            
            imageView = cell.snapshotViewAfterScreenUpdates(true)
            
            imageView?.frame = cell.frame
            
        }
        
        return imageView
    }
    
    func dataItemAtPoint(point: CGPoint) -> AnyObject?{
        
        var dataItem: AnyObject?
        
        
        if let indexPath = self.indexPathForItemAtPoint(point) {
            
            if let dragDropDS: DragAndDropCollectionViewDataSource = self.dataSource as? DragAndDropCollectionViewDataSource {
                
                dataItem = dragDropDS.collectionView(self, dataItemForIndexPath: indexPath)
            }
        }
        
        return dataItem
    }
    
    func startDraggingAtPoint(point: CGPoint) -> Void {
        
        self.draggingPathOfCellBeingDragged = self.indexPathForItemAtPoint(point)
        
        self.reloadData()
        
    }
    func stopDraggging() -> Void {
        
        if let idex = self.draggingPathOfCellBeingDragged {
            if let cell = self.cellForItemAtIndexPath(idex) {
                cell.hidden = true
            }
            
            self.draggingPathOfCellBeingDragged = nil
            self.reloadData()
        }
    }
    
    func dragDataItem(item: AnyObject) -> Void {
        
        if let dragDropDataSource = self.dataSource as? DragAndDropCollectionViewDataSource {
            
            if let existingIndexPath = dragDropDataSource.collectionView(self, indexPathForDataItem: item) {
                dragDropDataSource.collectionView(self, deleteDataItemAtIndexPath: existingIndexPath)
                
                self.deleteItemsAtIndexPaths([existingIndexPath])
            }
        }
        
    }
}

extension DragAndDropCollectionView: Droppable {
    
    func canDropAtRect(rect: CGRect) -> Bool {
        return true
    }
    func willMoveItem(item: AnyObject, inRect rect: CGRect) -> Void {
        let dragDropDataSource = self.dataSource as! DragAndDropCollectionViewDataSource // guaranteed to have a data source
        
        if let _ = dragDropDataSource.collectionView(self, indexPathForDataItem: item) {
            return
        }
        
        if let indexPath = self.indexPathForCellOverlappingRect(rect) {
            
            dragDropDataSource.collectionView(self, insertDataItem: item, atIndexPath: indexPath)
            
            self.draggingPathOfCellBeingDragged = indexPath
            
            self.insertItemsAtIndexPaths([indexPath])
            
        }
        
        currentInRect = rect
    }
    func didMoveItem(item: AnyObject, inRect rect: CGRect) -> Void {
        let dragDropDS = self.dataSource as! DragAndDropCollectionViewDataSource // guaranteed to have a ds
        
        if let existingIndexPath = dragDropDS.collectionView(self, indexPathForDataItem: item),
            indexPath = self.indexPathForCellOverlappingRect(rect) {
                
                if indexPath.item != existingIndexPath.item {
                    
                    dragDropDS.collectionView(self, moveDataItemFromIndexPath: existingIndexPath, toIndexPath: indexPath)
                    
                    self.moveItemAtIndexPath(existingIndexPath, toIndexPath: indexPath)
                    
                    self.draggingPathOfCellBeingDragged = indexPath
                    
                }
        }
        
        // Check Paging
        
        var normalizedRect = rect
        normalizedRect.origin.x -= self.contentOffset.x
        normalizedRect.origin.y -= self.contentOffset.y
        
        currentInRect = normalizedRect
        
        
        self.checkForEdgesAndScroll(normalizedRect)
    }
    func didMoveOutItem(item: AnyObject) -> Void {
        if let dragDropDataSource = self.dataSource as? DragAndDropCollectionViewDataSource {
            
            if let existngIndexPath = dragDropDataSource.collectionView(self, indexPathForDataItem: item) {
                
                dragDropDataSource.collectionView(self, deleteDataItemAtIndexPath: existngIndexPath)
                
                self.deleteItemsAtIndexPaths([existngIndexPath])
                
                if let idx = self.draggingPathOfCellBeingDragged {
                    if let cell = self.cellForItemAtIndexPath(idx) {
                        cell.hidden = false
                    }
                }
                
                self.draggingPathOfCellBeingDragged = nil
                
            }
            
        }
        
        currentInRect = nil
    }
    func dropDataItem(item: AnyObject, atRect: CGRect) -> Void {
        self.draggingPathOfCellBeingDragged = nil
        
        currentInRect = nil
        
        self.reloadData()

    }
}

