//
//  LocationCellView.swift
//  WhereAmI
//
//  Created by Hannah Estes on 9/12/21.
//

import Foundation
import UIKit

class LocationCellView: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    func setLabels(name: String?, coordinates: String?){
        if name != nil {
            nameLabel.text = name
        }
        if coordinates != nil {
            coordinatesLabel.text = coordinates
        }
    }
}
