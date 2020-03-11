//
//  ItemViewModelTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
@testable import Charge

class ItemViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init(){
        let item = CoreService.create(xCObjectType: .item, data: nil) as! Item
        let itemViewModel = ItemViewModel(item: item)
        XCTAssertNotNil(itemViewModel)
    }
    
    func test_init_setsItem(){
        let item = CoreService.create(xCObjectType: .item, data: nil) as! Item
        let itemViewModel = ItemViewModel(item: item)
        XCTAssertNotNil(itemViewModel.item)
    }
    
    func test_itemNum(){
        let data = [Item.Keys.itemNumber.rawValue : 17]
        let item = CoreService.create(xCObjectType: .item, data: data) as! Item
        let itemViewModel = ItemViewModel(item: item)
        XCTAssertEqual("17", itemViewModel.itemNum)
    }
    
    func test_itemDescription(){
        let data = [Item.Keys.itemDescription.rawValue : "This is a TEST description"]
        let item = CoreService.create(xCObjectType: .item, data: data) as! Item
        let itemViewModel = ItemViewModel(item: item)
        XCTAssertEqual("This is a TEST description", itemViewModel.description)
    }
    
    func testDateString(){
        let expectedDateString = "03/10/2020"
        let date = DateHelper.dateFrom(dateString: expectedDateString)
        let data = [Item.Keys.date.rawValue : date!]  as [String : Any]
        let item = CoreService.create(xCObjectType: .item, data: data) as! Item
        let itemViewModel = ItemViewModel(item: item)
        XCTAssertEqual("03/10/2020", itemViewModel.dateString)
    }
    

}
