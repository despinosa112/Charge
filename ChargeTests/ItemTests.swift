//
//  ItemTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
@testable import Charge

class ItemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func test_createEmptyItem(){
        let item = Item()
        XCTAssertNotNil(item)
    }

}
