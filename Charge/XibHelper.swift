//
//  XibHelper.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class XibHelper: NSObject {


    static func loadXIB<T: UIView>(named: String, type: T) -> T? {
        if let view = Bundle.main.loadNibNamed(named, owner: self, options: nil)?.first as? T{
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        } else {
            return nil
        }
    }
        

    
}
