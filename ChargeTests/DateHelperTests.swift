//
//  DateHelperTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
@testable import Charge

class DateHelperTests: XCTestCase {
    
    var todaysDate: Date!
    var todaysDateString: String!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let todaysDate = Date()
        self.todaysDateString = DateHelper.dateStringFrom(date: todaysDate)
        self.todaysDate = DateHelper.dateFrom(dateString: todaysDateString)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_today() {
        let todayString = DateHelper.today()
        XCTAssertEqual(self.todaysDateString, todayString)
    }
    
    func test_dateStringFromDate() {
        let dateString = self.todaysDateString
        let expectedDateString = DateHelper.dateStringFrom(date: self.todaysDate)
        XCTAssertEqual(dateString, expectedDateString)
    }
    
    func test_dateFromString_03_10_2020(){
        let actualDate = DateHelper.dateFrom(dateString:self.todaysDateString)
        XCTAssertEqual(self.todaysDate, actualDate!)
    }
    
    func test_dateFromString_invalid_return_Nil(){
        let actualDate = DateHelper.dateFrom(dateString:"3/310/2020")
        XCTAssertNil(actualDate)
    }

    

}
