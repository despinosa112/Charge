//
//  ItemTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
import CoreLocation
@testable import Charge

class ItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func test_createEmptyItem(){
        let emptyItem = CoreService.create(xCObjectType: .item, data: nil)
        XCTAssertNotNil(emptyItem)
    }
    
    func test_createItem_withDescription(){
        let data = [Item.Keys.itemDescription.rawValue : "Item Description TEST"] as! [String: Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        let actualItemDescription = item?.value(forKey: Item.Keys.itemDescription.rawValue) as! String
        XCTAssertEqual(actualItemDescription, "Item Description TEST")
    }
    
    func test_createItem_withItemNum(){
        let data = [Item.Keys.itemNumber.rawValue : 4] as! [String: Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        let actualItemNumber = item?.value(forKey: Item.Keys.itemNumber.rawValue) as! Int
        XCTAssertEqual(actualItemNumber, 4)
    }
    
    func test_createItem_withLocation(){
        let location = LocationHelper.locationFrom("37.785834, -122.406417")

        let data = [Item.Keys.location.rawValue : location] as! [String: Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        let actualLocation = item?.value(forKey: Item.Keys.location.rawValue) as! CLLocationCoordinate2D
        let latIsEqual = actualLocation.latitude == location?.latitude
        let longIsEqual = actualLocation.longitude == location?.longitude
        XCTAssertTrue(latIsEqual && longIsEqual)
    }
    
    func test_createItem_withDate(){
        let date = DateHelper.dateFrom(dateString: "03/08/1989")
        let data = [Item.Keys.date.rawValue : date] as! [String: Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        let actualDate = item?.value(forKey: Item.Keys.date.rawValue) as! Date
        XCTAssertEqual(actualDate, date)
    }
    
    func test_createItem_withComponents(){
        let innerComponentData0 = [Component.Keys.name.rawValue : "innerComponentData0"] as [String : Any]
        let innerComponent0 = CoreService.create(xCObjectType: .component, data: innerComponentData0)
        
        let innerComponentData1 = [Component.Keys.name.rawValue : "innerComponentData1"] as [String : Any]
        let innerComponent1 = CoreService.create(xCObjectType: .component, data: innerComponentData1)
        
        let data = [Item.Keys.components.rawValue : [innerComponent0, innerComponent1]] as [String : Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        let actualComponents = item?.value(forKey: Item.Keys.components.rawValue) as! [Component]
        let compIndex1Name = actualComponents[1].name as! String
        XCTAssertEqual(compIndex1Name, "innerComponentData1")
    }
    
    func test_createItem_withComponents_withComponents(){
        let innerComponentData = [Component.Keys.name.rawValue : "innerComponentData"] as [String : Any]
        let innerComponent = CoreService.create(xCObjectType: .component, data: innerComponentData)
        
        let outerComponentData = [Component.Keys.name.rawValue : "outerComponentData", Component.Keys.components.rawValue : [innerComponent]] as [String : Any]
        let outerComponent = CoreService.create(xCObjectType: .component, data: outerComponentData)
        let data = [Item.Keys.components.rawValue : [outerComponent]] as [String : Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        
        let actualOuterComponents = item?.value(forKey: Item.Keys.components.rawValue) as! [Component]
        let actualInnerComponents = actualOuterComponents[0].value(forKey: Component.Keys.components.rawValue) as! [Component]
        
        let actualInnerComponentName = actualInnerComponents[0].name as! String
        XCTAssertEqual(actualInnerComponentName, "innerComponentData")
    }
    

    
    

}
