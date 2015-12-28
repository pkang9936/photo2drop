//
//  WeatherHourlyForecastCollectionView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/27/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class WeatherHourlyForecastCollectionView: UICollectionView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
    }
}
extension WeatherHourlyForecastCollectionView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 15
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.hourlyWeatherForecastCell, forIndexPath: indexPath)
        
        return cell
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
