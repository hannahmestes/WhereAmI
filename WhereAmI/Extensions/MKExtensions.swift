//
//  MKExtensions.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/13/21.
//

import MapKit

extension MKPlacemark {
    func getDistanceFromUser() -> Double {
        // divide by 1609 to get distance in miles
        return (location?.distance(from: LocationService.shared.userLocation.coordinateLocation) ?? 0) / 1609
    }
}

extension MKMapItem {
    func getDistanceFromUser() -> Double {
        return placemark.getDistanceFromUser()
    }
}
