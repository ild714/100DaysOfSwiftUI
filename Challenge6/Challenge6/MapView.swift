//
//  MapView.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 16.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import MapKit

class LandmarkAnnotation: NSObject,MKAnnotation{
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String,coordinate: CLLocationCoordinate2D){
        self.title = title
        self.coordinate = coordinate
    }
}

struct MapView: UIViewRepresentable {
    
    let title: String
    
    class MapViewCoordinator: NSObject,MKMapViewDelegate{
        var mapViewController: MapView
    
        init(_ control: MapView){
            self.mapViewController = control
        }
    }
    
    func mapView(_ mapView:MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "View")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView{
        MKMapView(frame:.zero)
    }

//    func updateUIView(_ view: MKMapView, context: Context){
//        let coordinate = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)
//        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        view.setRegion(region, animated: true)
//        view.delegate = context.coordinator
//        let annotation = LandmarkAnnotation(title: title, coordinate: CLLocationCoordinate2D(latitude: 12.1, longitude: 12.2))
//        view.addAnnotation(annotation)
        
//        view.showsUserLocation = true
//        let locationManager = CLLocationManager()
//        let status = CLLocationManager.authorizationStatus()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
//
//        if status == .authorizedAlways || status == .authorizedWhenInUse{
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
//            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
//            let region = MKCoordinateRegion(center: location, span: span)
//            view.setRegion(region, animated: true)
//
//        }
//    }
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        let locationManager = CLLocationManager()
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
    }

}

