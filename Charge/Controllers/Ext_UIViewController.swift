//
//  Ext_UIViewController.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentOKAlertWith(title: String, message: String){
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            //
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addObserver(_ notification: NotificationHelper.Notification) {
        let notificationName = Notification.Name(rawValue: notification.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(didObserveNotification), name: notificationName, object: nil)
    }
    
    @objc func didObserveNotification(notification: NSNotification){
    }
    
    
}
