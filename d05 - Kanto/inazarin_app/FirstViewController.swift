//
//  FirstViewController.swift
//  inazarin_app
//
//  Created by Illia NAZARINA on 6/3/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Point: NSObject, MKAnnotation {
    let name: String?
    let desc: String
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, desc: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.desc = desc
        self.coordinate = coordinate
        
        super.init()
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return desc
    }
}

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var tableStruct: mapLoc?
    
    let pointsList: [Point] = [
        Point(name: "Ecole 42", desc: "BORN TO CODE?\n96 Boulevard Bessières, 75017 Paris", coordinate: CLLocationCoordinate2D(latitude: 48.896550, longitude: 2.318461)),
        Point(name: "UNIT Factory", desc: "27-inch iMacs, free wi-fi, PS and shower", coordinate: CLLocationCoordinate2D(latitude: 50.468855, longitude: 30.462169)),
        Point(name: "Meditation center", desc: "Place to ponder over life the universe and everything...", coordinate: CLLocationCoordinate2D(latitude: 50.461403, longitude: 30.477747)),
        Point(name: "McDonalds", desc: "Where fat people can smile cheerfully and complaine about their lifes", coordinate: CLLocationCoordinate2D(latitude: 50.447523, longitude: 30.522950)),
        
    ]
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = .hybrid
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.addAnnotations(pointsList)
        
        if let temp = tableStruct
        {
            centerMapOnLocation(location: CLLocation(latitude: temp.lat, longitude: temp.long))
        }
        else
        {
            centerMapOnLocation(location: CLLocation(latitude: 50.450985, longitude: 30.522569))
        }
    }
    
    @IBAction func goToUserLocation(_ sender: Any)
    {
        let temp:CLLocationCoordinate2D = locationManager.location!.coordinate
        let userCoordinates = CLLocation(latitude: temp.latitude, longitude: temp.longitude)
        centerMapOnLocation(location: userCoordinates)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
    }
    
    @IBAction func segControl(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .hybrid
        }
    }
    
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         guard let annotation = annotation as? Point else { return nil }
         let identifier = "marker"
         var view: MKMarkerAnnotationView
         if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
             dequeuedView.annotation = annotation
             view = dequeuedView
        } else {
             view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
             view.canShowCallout = true
             view.calloutOffset = CGPoint(x: -5, y: 5)
             view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
         }
        if let title = annotation.title, title == "Ecole 42"{//, McDonalds
            view.markerTintColor = UIColor.black
        } else if let title = annotation.title, title == "UNIT Factory"{
            view.markerTintColor = UIColor.yellow
        } else {
            view.markerTintColor = UIColor.green
        }
        
         return view
     }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Pressed! title==\(String(describing: view.annotation?.title))")
    }

}



