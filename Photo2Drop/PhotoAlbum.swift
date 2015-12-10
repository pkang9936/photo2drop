//
//  PhotoAlbum.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/1/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import UIKit

class PhotoAlbum {
    var albumImage: UIImage!
    var title = ""
    var numberOfPhotos = 0
    var photos:[PhotoInfo] = []
    
    init(title: String, albumImage: UIImage!, numberOfPhotos: Int, photos: [PhotoInfo]!) {
        self.albumImage = albumImage
        self.title = title
        self.numberOfPhotos = numberOfPhotos
        self.photos = photos
    }
    
    // MARK - Private
    
    static func createPhotoAlbums() -> [PhotoAlbum] {
        return [
            PhotoAlbum(title: "Camera Roll", albumImage: UIImage(named: "_6"), numberOfPhotos: 1550, photos: [
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "1_1")),
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "1_2")),
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "1_3")),
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "2_1")),
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "2_2")),
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "2_3"))
                ]),
            PhotoAlbum(title: "Favorites", albumImage: UIImage(named: "_2"), numberOfPhotos: 52, photos: [
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "2_1")),
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "2_2")),
                PhotoInfo(date: "12/3/2015", location: "Rochester", img: UIImage(named: "2_3"))
                ]),
            PhotoAlbum(title: "Selfies", albumImage: UIImage(named: "_3"), numberOfPhotos: 110, photos: []),
            PhotoAlbum(title: "Video", albumImage: UIImage(named: "_4"), numberOfPhotos: 133, photos: []),
            PhotoAlbum(title: "Burst", albumImage: UIImage(named: "_5"), numberOfPhotos: 8, photos: [])
        ]
    }
}