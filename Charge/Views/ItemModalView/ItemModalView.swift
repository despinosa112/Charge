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
    func didSelectCurrentLocation(itemModalView: ItemModalView)
    func didSelectManageComponents(itemModalView: ItemModalView)
}

class ItemModalView: UIView {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var itemNumberTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    @IBOutlet weak var componentsLabel: UILabel!
    
    
    var delegate: ItemModalViewDelegate?
    
    @IBAction func saveUpdate(_ sender: Any) {
        self.delegate?.didSaveUpdate(itemModalView: self)
    }
    
    @IBAction func close(_ sender: Any) {
        self.delegate?.didClose(itemModalView: self)
    }
    
    @IBAction func useCurrentLocation(_ sender: Any) {
        self.delegate?.didSelectCurrentLocation(itemModalView: self)
    }
    
    @IBAction func manageComponents(_ sender: Any) {
        self.delegate?.didSelectManageComponents(itemModalView: self)
    }
    
}
