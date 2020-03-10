//
//  ItemViewModel.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import Foundation
import CoreData

class ItemViewModel {
    
    var item: Item!
    
    init(item: Item) {
        self.item = item
    }
    
    var itemNum: String {
        get {
            return String(self.item.itemNumber)
        }
    }
    
    var description: String {
        get {
            return String(self.item.itemDescription ?? "")
        }
    }
    
}
