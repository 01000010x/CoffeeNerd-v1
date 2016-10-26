//
//  ShopsViewController.swift
//  CoffeeNerd
//
//  Created by Baptiste Leguey on 10/24/16.
//  Copyright © 2016 Baptiste Leguey. All rights reserved.
//

import UIKit
//import Foundation
import MapKit

class ShopsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // MARK: IBOutlet's
    
    @IBOutlet var mapView: MKMapView?
    
    
    // MARK: 
    
    var locationManager:CLLocationManager?
    let distanceSpan:Double = 500
    let clientID = "EMSHPNVP3SLW3MRBA5VVNAYCWTWWUS42MFLTR3T0PI3I5CMH"
    let secretID = "AEFQCBN34EGVIUZVJXH0BB1QZKRCGGJXXKZUKJE2MNXRXUZT"
    
    // MARK: UIViewController 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let mapView = self.mapView {
            mapView.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager!.requestAlwaysAuthorization()
            locationManager!.distanceFilter = 50 // Don't send location updates with a distance smaller than 50 meters between them
            locationManager!.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: CLLocationManager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegionMakeWithDistance((locations.last?.coordinate)!, distanceSpan, distanceSpan)
            mapView.setRegion(region, animated: true)
        }
    }
}
