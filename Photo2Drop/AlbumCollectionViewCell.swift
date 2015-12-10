//
//  AlbumCollectionViewCell.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 11/18/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var innerCellMask: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var album: PhotoAlbum! {
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        print("Update album Cell")
        imageView.image = album.albumImage
        //imageView.layer.cornerRadius = 8.0
        //imageView.layer.borderColor = UIColor.grayColor().CGColor
        //imageView.layer.borderWidth = 1.0
        //imageView.clipsToBounds = true
        
        titleLabel.text = album.title
        
        innerCellMask.layer.cornerRadius = 8.0
        innerCellMask.layer.borderColor = UIColor.grayColor().CGColor
        innerCellMask.layer.borderWidth = 1.0
        innerCellMask.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        //self.layer.borderColor = UIColor.grayColor().CGColor
        //self.layer.borderWidth = 0.5
        //self.backgroundColor = UIColor.grayColor()
    }
    
    func highlight() {
        //self.layer.borderColor = UIColor.blueColor().CGColor
       // self.layer.borderWidth = 1.0
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func removeHighlight() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    private var roundedImage = false
    
    func didChangeImageToRound () {
        //imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.grayColor().CGColor
        imageView.layer.borderWidth = 0.5
        imageView.clipsToBounds = true
        roundedImage = true
    }
    
    func didBlurImage (){
        
        let blur: UIBlurEffect = UIBlurEffect(style: .Light)
        let effectView: UIVisualEffectView = UIVisualEffectView(effect: blur)
        effectView.frame = imageView.frame
        effectView.alpha = 0.6
        effectView.contentMode = .ScaleAspectFill
        if roundedImage {
            effectView.layer.cornerRadius = effectView.frame.size.height / 2
            effectView.clipsToBounds = true
        }
        
        addSubview(effectView)
        
        
    }
}
