//
//  MapViewController.swift
//  Photo2Drop
//
//  Created by Kang, Puthyrak on 12/11/15.
//  Copyright © 2015 Kang, Puthyrak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: SWFrontViewController {

    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationCoordinate2DMake(44.089642, 92.52457)
        
        let span = MKCoordinateSpanMake(0.0002, 0.0002)
        let region = MKCoordinateRegion(center: location, span: span)
        
        Map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Veata home"
        annotation.subtitle = "Rainalee fmaily"
        Map.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
