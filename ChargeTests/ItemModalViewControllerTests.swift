//
//  ItemModalViewControllerTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
@testable import Charge

class ItemModalViewControllerTests: XCTestCase {
    
    var itemModalViewController: ItemModalViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.itemModalViewController = ItemModalViewController()
        CoreService.fetch(xCObjectType: .item, predicate: nil, sortDescriptors: nil) { (items) in
            let first = items?[0]
            self.itemModalViewController.item = first as! Item
            
            if let itemModalView: ItemModalView = XibHelper.loadXIB(named: "ItemModalView", type: ItemModalView()){
                self.itemModalViewController.itemModalView = itemModalView
            }
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init(){
        XCTAssertNotNil(self.itemModalViewController)
    }
    

    func test_setData_itemIsNil(){
        self.itemModalViewController.setData()
        XCTAssertEqual("0", self.itemModalViewController.itemModalView?.itemNumberTextField.text)
    }
    
    func test_setData_itemExists(){
        self.itemModalViewController.setData()
        XCTAssertEqual("Item Desc 1", self.itemModalViewController.itemModalView?.itemDescriptionTextView.text)
    }

}
