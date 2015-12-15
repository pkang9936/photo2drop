//
//  GetAlbumHandler.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/14/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import Photos

public protocol GetAlbumHandlerDelegate {
    func didGetAlbums(albums: [PhotoAlbumInfo])
    
    func didGetPhotosForAlbum(photos: [PhotoInfo])
}

public class GetAlbumHandler {
    public var delegate: AnyObject?
    
    public func getAllAlbums(){
        var albums = [PhotoAlbumInfo]()
        var collection:PHAssetCollection!
        let options:PHFetchOptions = PHFetchOptions()
        options.predicate = NSPredicate(format: "estimatedAssetCount >= 0")
        
        let userAlbums:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: options)
        
        userAlbums.enumerateObjectsUsingBlock { (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) -> Void in
            if object is PHAssetCollection {
                collection = object as! PHAssetCollection
                let album = PhotoAlbumInfo()
                album.title = collection.localizedTitle!
                album.numberOfPhotos = collection.estimatedAssetCount
                
               let result = PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
                
                if let lastAsset = result.lastObject as? PHAsset {
                    PHImageManager.defaultManager().requestImageForAsset(lastAsset, targetSize: CGSizeMake(70,70), contentMode: .AspectFill, options: nil, resultHandler: { (img: UIImage?, info: [NSObject : AnyObject]?) -> Void in
                        if let img = img {
                            album.albumImage = img
                        }
                    })
                }
                
                albums.append(album)
                
                
            }
        }
        (delegate as? GetAlbumHandlerDelegate)?.didGetAlbums(albums)
        
        
    }
    
    public func getPhotosForAlbum(albumInfo albumInfo: PhotoAlbumInfo! ) {
        var photos = [PhotoInfo]()
        let fechOptions = PHFetchOptions()
        fechOptions.predicate = NSPredicate(format: "title = %@", albumInfo.title)
        
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fechOptions)
        
        guard let rec = collection.firstObject as? PHAssetCollection else {return}
        
        let result = PHAsset.fetchAssetsInAssetCollection(rec, options: nil)
        
        for obj in result {
            let asset = obj as! PHAsset
            let photoInfo = PhotoInfo()
            
            //load image
            PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(50, 50), contentMode: .AspectFill, options: nil, resultHandler: { (im: UIImage?, info: [NSObject: AnyObject]?) -> Void in
                if let im = im {
                    photoInfo.image = im
                }
            })
            photos.append(photoInfo)
            
        }
        
        albumInfo.photos = photos
        
        //photos = PhotoAlbumInfo.createPhotoAlbums()[0].photos
        
        (delegate as? GetAlbumHandlerDelegate)?.didGetPhotosForAlbum(photos)
        
    }
}