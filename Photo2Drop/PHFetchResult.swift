//
//  PHFetchResult.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/14/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import Foundation
import Photos

extension PHFetchResult: SequenceType {
    public func generate() -> NSFastGenerator {
        return NSFastGenerator(self)
    }
}