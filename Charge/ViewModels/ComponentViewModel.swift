//
//  ComponentViewModel.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import Foundation

class ComponentViewModel {
    
    var component: Component!
    
    init(component: Component) {
        self.component = component
    }
    
    var name: String {
        get {
            guard let name = self.component.name else { return "" }
            return name
        }
    }
}
