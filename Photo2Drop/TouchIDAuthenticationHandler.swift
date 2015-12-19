//
//  TouchIDAuthenticationHandler.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/19/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import LocalAuthentication

public protocol TouchIDAuthenticationHandlerDelegate {
    func didSuccessfulAuthenticate()
    func didFailAuthenticate()
    func touchIDAuthenticationNotSupported()
}

public class TouchIDAuthenticationHandler {
    var delegate: TouchIDAuthenticationHandlerDelegate?
    
    public func authenticate() {
        let authContext: LAContext = LAContext()
        var error: NSError?
        if authContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            authContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason:  "Please scan your fingure to authenticate", reply: { (wasSuccessful: Bool, error: NSError?) in
                
                if wasSuccessful {
                    self.delegate?.didSuccessfulAuthenticate()
                } else {
                    self.delegate?.didFailAuthenticate()
                }
            
        })
        
        } else {
            self.delegate?.touchIDAuthenticationNotSupported()
        }
    }
}