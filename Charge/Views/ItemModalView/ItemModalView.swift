//
//  ItemModalView.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

protocol ItemModalViewDelegate {
    func didClose(itemModalView: ItemModalView)
    func didSaveUpdate(itemModalView: ItemModalView)
}

class ItemModalView: UIView {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var itemNumberTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    
    
    var delegate: ItemModalViewDelegate?
    
    @IBAction func saveUpdate(_ sender: Any) {
        self.delegate?.didSaveUpdate(itemModalView: self)
    }
    
    @IBAction func close(_ sender: Any) {
        self.delegate?.didClose(itemModalView: self)
    }
    
    @IBAction func useCurrentLocation(_ sender: Any) {
        
    }
    
    
}
