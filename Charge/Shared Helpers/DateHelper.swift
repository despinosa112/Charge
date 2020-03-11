//
//  DateHelper.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    
    //NOTE: This app is designed to handle only month/date/year, smaller units of time can be included at clients request
    
    static func today() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        return format.string(from: date)
    }
    
    static func dateStringFrom(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        return format.string(from: date)
    }
    
    static func dateFrom(dateString: String) -> Date? {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        return format.date(from: dateString)
    }

}
