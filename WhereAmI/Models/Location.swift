//
//  Location.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/12/21.
//

import Foundation
import CoreLocation
import MapKit

class Location: NSObject, Codable {
    
    let latitude: Double
    let longitude: Double
    var name: String?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var coordinateLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var coordinateString: String {
        return longitude.description + ", " + latitude.description
    }
    
    init(lat: Double, long: Double, name: String? = nil){
        self.latitude = lat
        self.longitude = long
        
        super.init()
        if name != nil {
            self.name = name
        } else {
            getLocationDescription()
        }
    
    }
    
    func asAnnotation() -> MKAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = coordinate
        return annotation
    }
    
    func getLocationDescription(){
        LocationService.geoCoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)){ placemarks, _ in
            if let place = placemarks?.first {
                self.name = "\(place)"
            }
          }
    }

}
