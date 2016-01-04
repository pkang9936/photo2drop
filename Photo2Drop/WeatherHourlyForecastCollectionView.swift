//
//  WeatherHourlyForecastCollectionView.swift
//  Photo2Drop
//
//  Created by Puthyrak Kang on 12/27/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit

class WeatherHourlyForecastCollectionView: UICollectionView {
    
    var weatherConditions:Array<WeatherCondition> = Array <WeatherCondition> () {
        didSet{
            self.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
    }
}
extension WeatherHourlyForecastCollectionView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return weatherConditions.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.hourlyWeatherForecastCell, forIndexPath: indexPath) as! WeatherHourlyForecastCollectionViewCollectionViewCell
        cell.render(weatherConditions[indexPath.row])
        return cell
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
