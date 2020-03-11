//
//  ComponentTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
@testable import Charge

class ComponentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_createEmptyComponent(){
        let emptyItem = CoreService.create(xCObjectType: .component, data: nil)
        XCTAssertNotNil(emptyItem)
    }
    
    func test_createComponent_withName(){
        let data = [Component.Keys.name.rawValue : "Component1"] as [String : Any]
        let component = CoreService.create(xCObjectType: .component, data: data)
        XCTAssertEqual(component?.value(forKey: Component.Keys.name.rawValue) as! String, "Component1")
    }
    
    func test_createComponent_withComponent(){
        let innerComponentData = [Component.Keys.name.rawValue : "innerComponentData"] as [String : Any]
        let innerComponent = CoreService.create(xCObjectType: .component, data: innerComponentData)
        
        let data = [Component.Keys.components.rawValue : innerComponent] as [String : Any]
        let component = CoreService.create(xCObjectType: .component, data: data)
        
        let actualInnerComponent = component?.value(forKey: Component.Keys.components.rawValue) as! Component
        let actualInnerComponentName = actualInnerComponent.value(forKey: Component.Keys.name.rawValue) as! String
        XCTAssertEqual(actualInnerComponentName, "innerComponentData")
    }
    
    
    func test_createComponent_withComponentArray(){
        let innerComponentData0 = [Component.Keys.name.rawValue : "innerComponentData0"] as [String : Any]
        let innerComponent0 = CoreService.create(xCObjectType: .component, data: innerComponentData0)
        
        let innerComponentData1 = [Component.Keys.name.rawValue : "innerComponentData1"] as [String : Any]
        let innerComponent1 = CoreService.create(xCObjectType: .component, data: innerComponentData1)
        
        let data = [Component.Keys.components.rawValue : [innerComponent0, innerComponent1]] as [String : Any]
        let component = CoreService.create(xCObjectType: .component, data: data)
        
        let actualInnerComponents = component?.value(forKey: Component.Keys.components.rawValue) as! [Component]
        let actualInnerComponent1 = actualInnerComponents[1]
        let actualInnerComponent1Name = actualInnerComponent1.name
        
        XCTAssertEqual(actualInnerComponent1Name, "innerComponentData1")
    }
    
    

}
