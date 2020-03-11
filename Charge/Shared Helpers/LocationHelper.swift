//
//  LocationHelper.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit
import CoreLocation

class LocationHelper: NSObject {

    static let shared = LocationHelper()
    
    var locationManager = CLLocationManager()
    
    
    func requestAuthorization(){
        LocationHelper.shared.locationManager.requestWhenInUseAuthorization()
    }
    
    func currentLocation() -> CLLocationCoordinate2D?{
        guard let coordinate = LocationHelper.shared.locationManager.location?.coordinate else { return nil}
        return coordinate
    }
    
    func currentLocationString() -> String {
        guard let coordinate = LocationHelper.shared.currentLocation() else { return "" }
        return LocationHelper.locationStringFrom(coordinate: coordinate)
    }
    
    static func locationStringFrom(coordinate: CLLocationCoordinate2D) -> String {
        return "\(coordinate.latitude), \(coordinate.longitude)"
    }
    
    static func locationFrom(_ string: String) -> CLLocationCoordinate2D? {
        var latString = ""
        var longString = ""
        
        let arr = Array(string)
        
        var isLat = true
        
        for char in arr {
            if char == ","  {
                isLat = false
            } else if char == " " {
                
            } else if isLat {
                latString.append(char)
            } else {
                longString.append(char)
            }
        }
        
        guard let lat = CLLocationDegrees(latString) else { return nil }
        guard let long = CLLocationDegrees(longString) else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    
}
