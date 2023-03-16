//
//  MKMapView+Extensions.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import MapKit

extension MKMapView {
    
    /// Update Map Region to specific location
    func setRegion(coordinates: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: radius, longitudinalMeters: radius)
        self.setRegion(region, animated: true)
    }
}
