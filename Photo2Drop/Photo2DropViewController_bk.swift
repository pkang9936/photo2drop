//
//  ViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 11/16/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import Photos

let reuseIdentifyPhotoCell = "PhotoCell"
let reuseIdentifyAlbumCel = "AlbumCell"
let albumName = "My App"

class Photo2DropViewController_bk: UIViewController{
    
    @IBOutlet weak var album1: UIImageView!
    @IBOutlet weak var album2: UIImageView!
    @IBOutlet weak var album3: UIImageView!
    
    var albumFound : Bool = false
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if the folder exists. if not create it
        let fechOptions = PHFetchOptions()
        //fechOptions.predicate = NSPredicate(format: "title = %@", albumName)
        
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fechOptions)
        
        if (collection.firstObject != nil) {
            //album found
            albumFound = true
            assetCollection = collection.firstObject as! PHAssetCollection
            
        }else {
            //create folder
            NSLog("\nFolder \"%@\" does not exist\nCreating now...", albumName)
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let _ = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                NSLog("after create album")
                }, completionHandler: {success, error in
                    NSLog("Creae of folder -> %@", success ? "Sucess" : "Error!")
                    self.albumFound = success ? true: false
                    
            })
        }
        
        //set album images
        album1.didChangeRoundCorner()
        album2.didChangeRoundCorner()
        album3.didChangeRoundCorner()
        
    }

    override func viewWillAppear(animated: Bool) {
        //fetch the photos from collection
        navigationController!.hidesBarsOnTap = false
        //self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        
        //Handle no photos in the assetCollection
        // ... have a label that say 'No Photo'...
        
        //self.photoCollectionView.reloadData()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! as String == "viewLargePhoto" {
            let controller: FullSizePhotoViewController = segue.destinationViewController as! FullSizePhotoViewController
            let indexPath: NSIndexPath = self.photoCollectionView.indexPathForCell(sender as! UICollectionViewCell)!
            
            controller.index = indexPath.item
            controller.photosAsset = self.photosAsset
            controller.assetCollection = self.assetCollection
        }
    }
    
    @IBAction func buttonCamera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            //load the camera interface
            let picker : UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
        } else {
            // no camera available
            let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func buttonPhotoAlbum(sender: AnyObject) {
        //load the camera interface
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
}

extension Photo2DropViewController_bk: UICollectionViewDataSource {
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollectionView {
            return (photosAsset != nil) ? photosAsset.count:0
        }
        return 3
    }
    
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell: PhotoThumbnailCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifyPhotoCell, forIndexPath: indexPath) as! PhotoThumbnailCollectionViewCell
        
        //modify cell
        let asset: PHAsset = photosAsset[indexPath.item] as! PHAsset
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil){
            result , info in
            cell.setThumbnailImage(result!)
            
        }
        return cell
        
    }
    
}

extension Photo2DropViewController_bk: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
}

extension Photo2DropViewController_bk: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //editor image 
            //let editedImage = info [UIImagePickerControllerEditedImage]
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                let assetPlaceholder = createAssetRequest.placeholderForCreatedAsset
                let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection, assets: self.photosAsset)
                albumChangeRequest!.addAssets([assetPlaceholder!])
                
                }, completionHandler: {success, error in
            
                    NSLog("Adding image to Library %@", success ? "Success":"Error")
                    picker.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}