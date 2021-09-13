//
//  LocationPopupView.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/12/21.
//

import Foundation
import UIKit
import CoreLocation

class LocationPopupView: UIView {
    @IBOutlet weak var locateButton: UIButton!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    let locationService: LocationService
    var didGetLocation: (() -> Void)?
    
    init(locationService: LocationService){
        self.locationService = locationService
        locationService.getLocation()
        super.init()
    }
    
    override init(frame: CGRect) {
        self.locationService = LocationService()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.locationService = LocationService()
        super.init(coder: coder)
    }
    
    struct Constants {
        static let labelAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 18)]
        static let coordinatesAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18)]
        static let latitudeLabelString: NSAttributedString = NSAttributedString(string: "Latitude: ", attributes: labelAttributes)
        static let longitudeLabelString: NSAttributedString = NSAttributedString(string: "Longitude: ", attributes: labelAttributes)
    }
    
    func setCoordinates(lat: Double, long: Double){
        longitudeLabel.textAlignment = .left
        latitudeLabel.textAlignment = .left
        let latString = NSMutableAttributedString()
        latString.append(Constants.latitudeLabelString)
        latString.append(NSAttributedString(string: String(format: "%.5f", lat), attributes: Constants.coordinatesAttributes))
        let longString = NSMutableAttributedString()
        longString.append(Constants.longitudeLabelString)
        longString.append(NSAttributedString(string: String(format: "%.5f", long), attributes: Constants.coordinatesAttributes))
        longitudeLabel.attributedText = longString
        latitudeLabel.attributedText = latString
    }
    
    func loadView() -> UIView {
        let bundleName = Bundle(for: type(of: self))
        let nibName = "LocationPopup"
        let nib = UINib(nibName: nibName, bundle: bundleName)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    @IBAction func touched(_ sender: Any) {
        didGetLocation?()
    }
    
    
}
