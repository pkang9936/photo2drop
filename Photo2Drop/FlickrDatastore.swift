//
//  FlickrDatastore.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/28/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import FlickrKit
/*
The api key can be requested at https://www.flickr.com/services/apps/create/.
*/

class FlickrDatastore {
    let flickr_key = "66ffb34151d0b6b4ff93a945f75301e9"
    let flickr_secret = "928cb581c3f80244"
    private let OBJECTIVE_FLICKR_API_KEY = "66ffb34151d0b6b4ff93a945f75301e9"
    private let OBJECTIVE_FLICKR_API_SHARED_SECRET = "928cb581c3f80244"
    private let GROUP_ID = "1463451@N25"
    
    func retrieveImageAtLat(lat: Double, lon: Double, closure: (image: UIImage?)->Void){
        let fk = FlickrKit.sharedFlickrKit()
        
        fk.initializeWithAPIKey(OBJECTIVE_FLICKR_API_KEY, sharedSecret: OBJECTIVE_FLICKR_API_SHARED_SECRET)
        fk.call("flickr.photos.search", args: ["group_id": GROUP_ID,
            "lat": "\(lat)",
            "lon": "\(lon)",
            "radius":"10"], maxCacheAge: FKDUMaxAgeOneHour) {
                (response, error) -> Void in
                self.extractImageFk(fk, response: response, error: error, closure: closure)
        }
    }

    private func extractImageFk(fk: FlickrKit, response: AnyObject?, error: NSError?, closure: (image: UIImage?) -> Void) {
        
        if let response = response as? [String:AnyObject] {
            if let photos = response["photos"] as? [String:AnyObject] {
                if let listOfPhotos: AnyObject = photos["photo"] {
                    if listOfPhotos.count > 0 {
                        let randomIndex = Int(arc4random_uniform(UInt32(listOfPhotos.count)))
                        let photo = listOfPhotos[randomIndex] as! [String:AnyObject]
                        let url = fk.photoURLForSize(FKPhotoSizeMedium640, fromPhotoDictionary: photo)
                        let image = UIImage(data: NSData(contentsOfURL: url)!)
                       dispatch_async(dispatch_get_main_queue()){
                            closure(image: image!)
                       }
                    }
                } else {
                    print(error)
                    print(response)
                }
            }
        }
        
    }
}