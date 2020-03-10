//
//  NotificationHelperTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
@testable import Charge

class NotificationHelperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_notification_saveNewItem(){
        expectation(forNotification: Notification.Name(rawValue: NotificationHelper.Notification.saveNewItem.rawValue), object: nil, handler: nil)
        NotificationHelper.post(notification: .saveNewItem, data: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_notification_updateItem(){
        expectation(forNotification: Notification.Name(rawValue: NotificationHelper.Notification.updateItem.rawValue), object: nil, handler: nil)
        NotificationHelper.post(notification: .updateItem, data: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }


    

}
