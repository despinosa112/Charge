//
//  NotificationHelper.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class NotificationHelper: NSObject {
    
    enum Notification: String {
        case saveNewItem = "SaveNewItem"
        case updateItem = "UpdateItem"
    }
    
    static func post(notification: Notification, data: [String: Any]?){
        let notificationName = NSNotification.Name(rawValue: notification.rawValue)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: data)
    }

}
