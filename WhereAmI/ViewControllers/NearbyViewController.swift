//
//  NearbyViewController.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/12/21.
//

import Foundation
import UIKit
import MapKit

class NearbyViewController: UITableViewController {
    
    var amenities: Amenities = Amenities()
    var locationService: LocationService = LocationService.shared
    
    override func viewWillAppear(_ animated: Bool) {
        amenities = locationService.nearbyLocations
    }
    
    // location cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)

        let section = amenities.sections[indexPath.section]
        let location = section.locations[indexPath.row]

        cell.textLabel?.text = location.placemark.name
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = String(format: "%.1f miles", location.placemark.getDistanceFromUser())
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return amenities.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amenities.sections[section].locations.count
    }
    
    // section headers
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if amenities.sections[section].locations.isEmpty {
            return "No \(amenities.sections[section].amenityType.rawValue) within 25 miles"
        }
        return amenities.sections[section].amenityType.rawValue
    }
    
    // open selected location in Maps
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        amenities.sections[indexPath.section].locations[indexPath.row].openInMaps()
    }
    
}
