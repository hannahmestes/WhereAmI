//
//  AmenitiesSearchService.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/12/21.
//

import Foundation
import MapKit



class Amenities: NSObject {
    var sections: [AmenitySection] {
        [cafes,
         restaurants,
         parks,
         hospitals,
         policeStations,
         fireStations]
    }
    
    var fireStations: AmenitySection = AmenitySection(name: .fire)
    var policeStations: AmenitySection = AmenitySection(name: .police)
    var cafes: AmenitySection = AmenitySection(name: .cafes)
    var hospitals: AmenitySection = AmenitySection(name: .hospitals)
    var restaurants: AmenitySection = AmenitySection(name: .restaurants)
    var parks: AmenitySection = AmenitySection(name: .parks)
    
}

enum AmenityType: String {
    case fire = "Fire Stations"
    case police = "Police Stations"
    case cafes = "Cafes"
    case hospitals = "Hospitals"
    case restaurants = "Restaurants"
    case parks = "Parks"
}

class AmenitySection: NSObject {
    let amenityType: AmenityType
    var locations: [MKMapItem]
    
    init(name: AmenityType, locations: [MKMapItem] = []){
        self.amenityType = name
        self.locations = locations
    }
}
