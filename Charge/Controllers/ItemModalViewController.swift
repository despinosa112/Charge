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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutModal()
    }

    
    func layoutModal(){
        let itemModalView: ItemModalView = XibHelper.loadXIB(named: "ItemModalView", type: ItemModalView())!
        self.itemModalView = itemModalView
        self.view.addSubview(itemModalView)
        
        itemModalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        itemModalView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -100).isActive = true
        itemModalView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        itemModalView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        itemModalView.delegate = self
        itemModalView.layer.cornerRadius = 8
        itemModalView.layer.masksToBounds = true
    }

}

extension ItemModalViewController: ItemModalViewDelegate {
    func didClose(itemModalView: ItemModalView) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSaveUpdate(itemModalView: ItemModalView) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
}
