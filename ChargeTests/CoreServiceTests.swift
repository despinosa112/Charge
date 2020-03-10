//
//  CoreService.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
@testable import Charge

class CoreServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        clearItemData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        clearItemData()
    }
    
    func clearItemData(){
        CoreService.fetch(xCObjectType: .item, predicate: nil, sortDescriptors: nil) { (items) in
            if items != nil {
                for item in items! {
                    CoreService.delete(xCObject: item)
                }
            }
        }
    }

    func test_create(){
        let emptyItem = CoreService.create(xCObjectType: .item, data: nil)
        XCTAssertNotNil(emptyItem)
    }
    
    func test_save_and_fetch_(){
        let data = [Item.Keys.itemDescription.rawValue : "This is an item description"] as [String : Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        CoreService.save(item!)
        CoreService.fetch(xCObjectType: .item, predicate: nil, sortDescriptors: nil) { (items) in
            let actualItem = items![0]
            let expectedItem = item!
            XCTAssertEqual(actualItem, expectedItem)
        }
    }
    
    func test_delete(){
        let data = [Item.Keys.itemDescription.rawValue : "This item will be deleted"] as [String : Any]
        let item = CoreService.create(xCObjectType: .item, data: data)
        CoreService.save(item!)
        clearItemData()
        CoreService.fetch(xCObjectType: .item, predicate: nil, sortDescriptors: nil) { (items) in
            let actualItemCount = items?.count
            XCTAssertEqual(0, actualItemCount)
        }
    }

    
    
    

}
