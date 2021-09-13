//
//  LocationService.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/12/21.
//

import Foundation
import CoreLocation
import MapKit

public class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()
    
    var locationManager = CLLocationManager()
    static let geoCoder = CLGeocoder()
    var userLocation = Location(lat: 0, long: 0)
    var nearbyLocations: Amenities = Amenities()
    
    func requestAuthorization(){
        self.locationManager.requestWhenInUseAuthorization()
    }
        
    func getLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[0] as CLLocation

        manager.stopUpdatingLocation() // immediately stop in order to only retrieve it once
        self.userLocation = Location(lat: location.coordinate.latitude, long: location.coordinate.longitude, name: self.userLocation.name)
        searchForAmenities(near: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func search(query: String, near coordinate: CLLocationCoordinate2D) -> MKLocalSearch {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        searchRequest.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.36, longitudeDelta: 0.36))
        searchRequest.resultTypes = .pointOfInterest
        
        let localSearch = MKLocalSearch(request: searchRequest)
        return localSearch
    }
    
    func searchForAmenities(near coordinate: CLLocationCoordinate2D){
        nearbyLocations.sections.forEach{ amenitySection in
            searchForLocations(amenitySection: amenitySection, near: coordinate)
        }
    }
    
    func searchForLocations(amenitySection: AmenitySection, near coordinate: CLLocationCoordinate2D){
        search(query: amenitySection.amenityType.rawValue, near: coordinate).start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            amenitySection.locations = response?.mapItems ?? []
            amenitySection.locations.sort(by: {mapItem1, mapItem2 in return mapItem1.getDistanceFromUser() < mapItem2.getDistanceFromUser()})
        }
    }
    
}
