//
//  GetAuthorizationToUsePhotoAlbum.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/17/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import Photos

public protocol GetAuthorizationToUsePhotoAlbumHandlerDelegate {
    func didAuthorized()
    func didNotDetermined()
    func didRestricted()
    func didDenied()
}

public class GetAuthorizationToUsePhotoAlbumHandler {
    public var delegate: GetAuthorizationToUsePhotoAlbumHandlerDelegate?
    
    public func checkAuthorizationToUsePhotoAlbum() {
        
        let status = PHPhotoLibrary.authorizationStatus()
        self.authorizationStatus(status)
    }
    
    public func resetAuthorization() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    public func requestAuthorization () {
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) -> Void in
            self.authorizationStatus(status)
        }
    }
   
    
    private func authorizationStatus(status: PHAuthorizationStatus) {
        switch status {
        case .Authorized:
        self.delegate?.didAuthorized()
        case .NotDetermined:
        self.delegate?.didNotDetermined()
        case .Restricted:
        self.delegate?.didRestricted()
        case .Denied:
        self.delegate?.didDenied()
        }
    }
}