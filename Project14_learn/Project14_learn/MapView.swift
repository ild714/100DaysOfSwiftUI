//
//  MapView.swift
//  Project14_learn
//
//  Created by Ильдар Нигметзянов on 06.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        
        init(_ parent: MapView){
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation:MKAnnotation)->MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
    }
    
    func makeUIView(context: Context)->MKMapView{
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView,context: Context){
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
