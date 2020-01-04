//
//  Church.swift
//  Life_in_Bible
//
//  Created by Mohammad Saiful Kabir on 02/01/2020.
//  Copyright © 2020 Mohammad Saiful Kabir. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AddressBook

class Church: NSObject, MKAnnotation{
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
        
    init(title: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
    class func from(json: JSON) -> Church? {
        
        var title: String
        if let unwrappedTitle = json["title"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }
    
        let lat = json["lat"].doubleValue
        let long = json["long"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        return Church(title: title, coordinate: coordinate)
    } 

}
