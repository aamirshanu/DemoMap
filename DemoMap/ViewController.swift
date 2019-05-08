//
//  ViewController.swift
//  DemoMap
//
//  Created by mac on 07/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        

        let camera = GMSCameraPosition.camera(withLatitude: 28.704060, longitude: 77.102493, zoom: 6.0, bearing: 270, viewingAngle: 45)
        var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isTrafficEnabled = true
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        
        view = mapView
        mapView.delegate = self
        
//        let location = CLLocationCoordinate2DMake(latitude: 28.704060, longitude: 77.102493)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "Hello"
//        mapView.
//

        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 28.704060, longitude: 77.102493)
        marker.title = "Delhi"
        marker.snippet = "India"
        marker.map = mapView
        marker.icon = UIImage(named: "pin")
       // marker.icon = GMSMarker.markerImage(with: .green)
        //marker.isFlat = true

    }
    
    // Tapped on map shows details
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String,
                 name: String, location: CLLocationCoordinate2D) {
        print("You tapped \(name): \(placeID), \(location.latitude)/\(location.longitude)")

    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last)
    }

}

