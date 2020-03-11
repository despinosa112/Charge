//
//  XibHelperTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
@testable import Charge

class XibHelperTests: XCTestCase {

    var itemModalView: ItemModalView?    
    
    override func setUp() {
        super.setUp()
        setupData()
    }
    
    func setupData(){
        if let itemModalView: ItemModalView = XibHelper.loadXIB(named: "ItemModalView", type: ItemModalView()){
            self.itemModalView = itemModalView
        }
    }
    
    func testLoadXibLoadsSuccessfully(){
        XCTAssertNotNil(self.itemModalView)
    }
}
