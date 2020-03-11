//
//  ItemValidator.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class ItemValidator: NSObject {
    
    enum isValidCode: Int {
        case success = 0
        case invalidNumber = 1
        case invalidDate = 2
        case invalidLocation = 3
    }
    

    static func validate(itemModalView: ItemModalView) -> Int {
        if Int(itemModalView.itemNumberTextField.text!) == nil {
            return isValidCode.invalidNumber.rawValue
        }
        if DateHelper.dateFrom(dateString: itemModalView.dateTextField.text ?? "") == nil {
            return isValidCode.invalidDate.rawValue
        }
        if LocationHelper.locationFrom(itemModalView.locationTextField.text ?? "") == nil {
            return isValidCode.invalidLocation.rawValue
        }
        return isValidCode.success.rawValue
    }
}
