//
//  ItemValidatorTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
@testable import Charge

class ItemValidatorTests: XCTestCase {
    
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

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_success(){
        self.itemModalView?.itemNumberTextField.text = "2"
        self.itemModalView?.dateTextField.text = "05/08/1989"
        self.itemModalView?.locationTextField.text = "37.785834, -122.406417"
        let returnCode = ItemValidator.validate(itemModalView: self.itemModalView!)
        XCTAssertEqual(0, returnCode)
    }
    
    func test_invaidItemNumber(){
        self.itemModalView?.itemNumberTextField.text = "r"
        self.itemModalView?.dateTextField.text = "05/08/1989"
        self.itemModalView?.locationTextField.text = "37.785834, -122.406417"
        let returnCode = ItemValidator.validate(itemModalView: self.itemModalView!)
        XCTAssertEqual(1, returnCode)
    }
    
    func test_invaidDate(){
        self.itemModalView?.itemNumberTextField.text = "4"
        self.itemModalView?.dateTextField.text = "05/08r/1989"
        self.itemModalView?.locationTextField.text = "37.785834, -122.406417"
        let returnCode = ItemValidator.validate(itemModalView: self.itemModalView!)
        XCTAssertEqual(2, returnCode)
    }
    
    func test_invaidLocation(){
        self.itemModalView?.itemNumberTextField.text = "4"
        self.itemModalView?.dateTextField.text = "05/08/1989"
        self.itemModalView?.locationTextField.text = "37.78583f4, -122.406417"
        let returnCode = ItemValidator.validate(itemModalView: self.itemModalView!)
        XCTAssertEqual(3, returnCode)
    }

}
