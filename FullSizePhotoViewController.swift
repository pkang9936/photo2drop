//
//  FullSizePhotoViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 11/16/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import Photos

class FullSizePhotoViewController: UIViewController {
    
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var index: Int = 0

    @IBOutlet weak var largeSizeImageView: UIImageView!
    
    @IBAction func buttonExport(sender: AnyObject) {
        print("Export")
    }
    @IBAction func buttonCancel(sender: AnyObject) {
        print("Cancel")
        self.navigationController!.popViewControllerAnimated(true)
    }
    @IBAction func actionTrash(sender: AnyObject) {
        print("Trash")
        let alert = UIAlertController(title: "Delete Image", message: "Are you sure you want to delete this image?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: {(alertAction) in
            NSLog("Delete photo")
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
                request!.removeAssets([self.photosAsset[self.index]])
                
                }, completionHandler: {(success, error ) in
            
                    NSLog("\nDelete image -> %@", success ? "Success":"Error!")
                    alert.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
                    if(self.photosAsset.count == 0){
                        //no photo left
                        self.largeSizeImageView.image = nil
                        print("No Images Left!")
                    }
                    if self.index >= self.photosAsset.count {
                        self.index = self.photosAsset.count - 1
                    }
                    self.displayPhoto()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { alertAction in
            //Do not delete photo
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        navigationController!.hidesBarsOnTap = true
        self.displayPhoto()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayPhoto() {
        let imageManager = PHImageManager.defaultManager()
        _ = imageManager.requestImageForAsset(self.photosAsset[self.index] as! PHAsset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil, resultHandler: {
            result, info in
        
            self.largeSizeImageView.image = result
        })
    }
}
