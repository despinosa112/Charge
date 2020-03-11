//
//  LocationHelperTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
import CoreLocation
@testable import Charge

class LocationHelperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func test_currentLocation(){
        let currentLocation = LocationHelper.shared.currentLocation()
        XCTAssert(currentLocation is CLLocationCoordinate2D)
    }
    
    func test_currentLocationString(){
        let currentLocationString = LocationHelper.shared.currentLocationString()
        XCTAssert(currentLocationString is String)
    }
    
    func test_LocationStringFromCoordinate(){
        let coordinate = LocationHelper.locationFrom("37.785834, -122.406417")
        let locationString = LocationHelper.locationStringFrom(coordinate: coordinate!)
        XCTAssertEqual("37.785834, -122.406417", locationString)
    }

    func test_locationFromString(){
        let location = LocationHelper.locationFrom("37.785834, -122.406417")
        let expectedCoordinate = CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417)
        let latIsEqual = expectedCoordinate.latitude == location!.latitude
        let longIsEqual = expectedCoordinate.longitude == location!.longitude
        XCTAssert(latIsEqual && longIsEqual)
    }
    
    func test_locationFromString_Invalid(){
        let location = LocationHelper.locationFrom("37.785834rw, -122.406417")
        XCTAssertNil(location)

    }
    
    

}
