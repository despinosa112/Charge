//
//  ComponentViewModelTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
@testable import Charge

class ComponentViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func test_init(){
        let component = CoreService.create(xCObjectType: .component, data: nil) as! Component
        let componentViewModel = ComponentViewModel(component: component)
        XCTAssertNotNil(componentViewModel)
    }
    
    func test_init_setsComponent(){
        let component = CoreService.create(xCObjectType: .component, data: nil) as! Component
        let componentViewModel = ComponentViewModel(component: component)
        XCTAssertNotNil(componentViewModel.component)
    }

    func test_name(){
        let data = [Component.Keys.name.rawValue : "My special name"]
        let component = CoreService.create(xCObjectType: .component, data: data) as! Component
        let componentViewModel = ComponentViewModel(component: component)
        XCTAssertEqual("My special name", componentViewModel.name)
    }
    
    func test_name_empty(){
        let component = CoreService.create(xCObjectType: .component, data: nil) as! Component
        let componentViewModel = ComponentViewModel(component: component)
        XCTAssertEqual("", componentViewModel.name)
    }
}
