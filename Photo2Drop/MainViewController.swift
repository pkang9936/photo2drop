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

class MainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var avatarImage:UIImageView!
    @IBOutlet var header:UIView!
    @IBOutlet var headerLabel:UILabel!
    
    // MARK - Rearrange viewcell
    var canvas: UIView? {
        didSet {
            if canvas != nil {
                self.calculateBorders()
            }
        }
    }
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    var collectionViewFrameInCanvas: CGRect = CGRectZero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        
        header.clipsToBounds = true
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
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if avatarImage.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
                
            }else {
                if avatarImage.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        avatarImage.layer.transform = avatarTransform
    }
    
    @IBAction func shamelessActionThatBringsYouToMyTwitterProfile() {
        
        if !UIApplication.sharedApplication().openURL(NSURL(string:"twitter://user?screen_name=bitwaker")!){
            UIApplication.sharedApplication().openURL(NSURL(string:"https://twitter.com/bitwaker")!)
        }
    }
    
    // MARK - helping method to rearrange album celeection cell
    private func calculateBorders() {
        
        if let collectionview = self.albumCollectionView {
            
            collectionViewFrameInCanvas = collectionview.frame
            
            if self.canvas != collectionview.superview {
                collectionViewFrameInCanvas = self.canvas!.convertRect(collectionViewFrameInCanvas, fromView: collectionview)
            }
            
            var leftRect: CGRect = collectionViewFrameInCanvas
            
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.AlbumCellIdentifier, forIndexPath: indexPath)
        
       
        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension MainViewController: UICollectionViewFlowLayout {
    
}

extension MainViewController:  UIGestureRecognizer {
    
}


