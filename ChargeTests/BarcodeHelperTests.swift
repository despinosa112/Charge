//
//  BarcodeHelperTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
import CoreLocation
@testable import Charge

class BarcodeHelperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_testBarcodeGenerator(){
        let barcodeImage = BarcodeHelper.generateBarcode(from: "TEST")
        XCTAssert(barcodeImage! is UIImage)
    }



}
