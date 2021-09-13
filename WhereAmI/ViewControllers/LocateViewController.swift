//
//  LocateViewController.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/12/21.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class LocateViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    private let locationService: LocationService = LocationService.shared
    private let overlayView: LocationPopupView
    
    let locationManager = CLLocationManager()
    
    required init?(coder: NSCoder) {
        overlayView = LocationPopupView(locationService: locationService).loadView() as! LocationPopupView
        super.init(coder: coder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.addSubview(overlayView)
        overlayView.didGetLocation = setMapCenter
        addConstraints()
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func setMapCenter(){
        // use 0.5 for lat/long delta to create roughly 25 mi radius
        // one longitude degree = 54.6 mi
        let coordinateRegion = MKCoordinateRegion(center: locationService.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(mapView.regionThatFits(coordinateRegion), animated: true)
        overlayView.setCoordinates(lat: locationService.userLocation.latitude, long: locationService.userLocation.longitude)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor, constant: -54),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 125)
        ])
    }
    

}
