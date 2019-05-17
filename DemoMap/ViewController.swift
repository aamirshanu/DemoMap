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
import GooglePlaces

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate {

    @IBOutlet var googleMapView: GMSMapView!
    var locationManager = CLLocationManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        

        createGoogleMap()
       
    }
    
    func createGoogleMap(){
        
        let camera = GMSCameraPosition.camera(withLatitude: 28.704060, longitude: 77.102493, zoom: 6.0, bearing: 270, viewingAngle: 45)
        var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        mapView.isTrafficEnabled = true
                mapView.isMyLocationEnabled = true
        self.googleMapView.settings.compassButton = true
        //        mapView.settings.myLocationButton = true
        
        self.googleMapView.camera = camera
        self.googleMapView.delegate = self
        self.googleMapView.isMyLocationEnabled = true
        self.googleMapView.settings.myLocationButton = true
        
        //view = mapView
        self.googleMapView.delegate = self
        
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 28.704060, longitude: 77.102493)
        marker.title = "Delhi"
        marker.snippet = "India"
        marker.map = googleMapView
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
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        self.googleMapView.isMyLocationEnabled = true
//    }
//
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//
//        self.googleMapView.isMyLocationEnabled = true
//        if (gesture) {
//            mapView.selectedMarker = nil
//        }
//
//    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        self.googleMapView.camera = camera
        self.dismiss(animated: true, completion: nil) // dismiss after select place
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
        print("Error Auto Complete \(error)")
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
    
    
    
    @IBAction func btnPickPoint(_ sender: UIButton) {
        autoCompleteController()
        
    }
    @IBAction func btnDropPoint(_ sender: UIButton) {
        autoCompleteController()
    }
    
    func autoCompleteController(){
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: false, completion: nil)
        
    }
}

