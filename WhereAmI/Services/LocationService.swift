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

        //manager.stopUpdatingLocation() // immediately stop in order to only retrieve it once
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
        search(query: AmenityType.fire.rawValue, near: coordinate).start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            self.nearbyLocations.fireStations.locations = response?.mapItems ?? []
        }
        
        search(query: AmenityType.police.rawValue, near: coordinate).start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            self.nearbyLocations.policeStations.locations = response?.mapItems ?? []
        }
        
        search(query: AmenityType.school.rawValue, near: coordinate).start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            self.nearbyLocations.schools.locations = response?.mapItems ?? []
        }
        
        search(query: AmenityType.hospitals.rawValue, near: coordinate).start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            self.nearbyLocations.hospitals.locations = response?.mapItems ?? []
        }
        
        search(query: AmenityType.restaurants.rawValue, near: coordinate).start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            self.nearbyLocations.restaurants.locations = response?.mapItems ?? []
        }
        
        search(query: AmenityType.parks.rawValue, near: coordinate).start { (response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            self.nearbyLocations.parks.locations = response?.mapItems ?? []
        }
    }
    
}

extension MKPlacemark {
    func getDistanceFromUser() -> Double {
        // divide by 1609 to get distance in miles
        return (location?.distance(from: LocationService.shared.userLocation.coordinateLocation) ?? 0) / 1609
    }
}
