//
//  AddItemModalViewController.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class ItemModalViewController: ViewController {
    
    var itemModalView: ItemModalView?

    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutModal()
        self.modalOverlay.isHidden = false
        self.view.backgroundColor = .clear
    }

    
    func layoutModal(){
        let itemModalView: ItemModalView = XibHelper.loadXIB(named: "ItemModalView", type: ItemModalView())!
        self.itemModalView = itemModalView
        self.view.addSubview(itemModalView)
        
        itemModalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        itemModalView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -150).isActive = true
        itemModalView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        itemModalView.heightAnchor.constraint(equalToConstant: 350).isActive = true

        itemModalView.delegate = self
        
        //Additional Styling
        itemModalView.layer.cornerRadius = 8
        itemModalView.layer.masksToBounds = true
        itemModalView.itemDescriptionTextView.layer.borderWidth = 1
        itemModalView.itemDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        itemModalView.itemDescriptionTextView.layer.cornerRadius = 4
        itemModalView.itemDescriptionTextView.layer.masksToBounds = true
    }
    
    
    func createAndSaveNewItem(){
        guard let newItem = CoreService.create(xCObjectType: .item, data: nil) else { return }
        CoreService.save(newItem)
        NotificationHelper.post(notification: .saveNewItem, data: nil)
    }

}

extension ItemModalViewController: ItemModalViewDelegate {
    
    func didClose(itemModalView: ItemModalView) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSaveUpdate(itemModalView: ItemModalView) {
        createAndSaveNewItem()
        self.dismiss(animated: true, completion: nil)

    }
    
    
}
