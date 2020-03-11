//
//  ItemViewModel.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import UIKit

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
    
    var dateString: String {
        get {
            guard let date = self.item.date else { return "" }
            return DateHelper.dateStringFrom(date: date)
        }
    }
    
    var locationString: String {
        get {
            guard let coordString = self.item.location as? String else { return ""}
            return coordString
        }
    }
    
    var barcode: UIImage {
        get {
            let objectIdString = self.item.objectID.uriRepresentation().absoluteString
            return BarcodeHelper.generateBarcode(from: objectIdString) ?? UIImage()
        }
    }
    
}
