//
//  AddItemModalViewController.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit
import CoreData

class ItemModalViewController: ViewController {
    
    var itemModalView: ItemModalView?

    var item: Item?
    
    var itemComponents: [Component]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutModal()
        self.modalOverlay.isHidden = false
        self.view.backgroundColor = .clear
        self.addObserver(.componentsFinished)
        setData()
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
        
        if self.item != nil {
            self.itemModalView?.saveButton.setTitle("Update", for: .normal)
        }
    }
    
    func setData(){
        
        if item == nil {
            self.itemModalView?.itemNumberTextField.text = "0"
            self.itemModalView?.dateTextField.text = DateHelper.today()
        } else {
            let itemViewModel = ItemViewModel(item: self.item!)
            self.itemModalView?.itemNumberTextField.text = itemViewModel.itemNum
            self.itemModalView?.itemDescriptionTextView.text = itemViewModel.description
            self.itemModalView?.dateTextField.text = itemViewModel.dateString
            self.itemModalView?.locationTextField.text = itemViewModel.locationString
        }
    }
    
    func createAndSaveNewItem(){
        var data = [String : Any]()
        if let itemNum = Int(self.itemModalView!.itemNumberTextField.text!) {
            let keyString = Item.Keys.itemNumber.rawValue
            data[keyString] = itemNum as Any
        }
        if let itemDescription = self.itemModalView?.itemDescriptionTextView.text {
            let keyString = Item.Keys.itemDescription.rawValue
            data[keyString] = itemDescription as Any
        }
        if let date = DateHelper.dateFrom(dateString: self.itemModalView?.dateTextField.text ?? "") {
            let keyString = Item.Keys.date.rawValue
             data[keyString] = date as Any
        }
        if let location = LocationHelper.locationFrom(self.itemModalView?.locationTextField.text ?? "") {
            let locationString = LocationHelper.locationStringFrom(coordinate: location)
            let keyString = Item.Keys.location.rawValue
            data[keyString] = locationString as Any
        }
        guard let newItem = CoreService.create(xCObjectType: .item, data: data) else { return }
        CoreService.save(newItem)
        NotificationHelper.post(notification: .saveNewItem, data: nil)
    }
    
    func updateCurrentItem(){
        self.item?.itemDescription = self.itemModalView?.itemDescriptionTextView.text
        if let itemNum = Int64(self.itemModalView?.itemNumberTextField.text ?? "error") {
            self.item?.itemNumber = itemNum
        }
        if let date = DateHelper.dateFrom(dateString: self.itemModalView?.dateTextField.text ?? "") {
            self.item?.date = date
        }
        if let location = LocationHelper.locationFrom(self.itemModalView?.locationTextField.text ?? "") {
            let locationString = LocationHelper.locationStringFrom(coordinate: location)
            item?.location = locationString as NSObject
        }
        guard let managedObject = self.item else { return }
        CoreService.save(managedObject)
        NotificationHelper.post(notification: .updateItem, data: nil)
    }
    
    func handleErrorWithInvalidCode(_ invalidCode: Int) {
        switch invalidCode {
        case 1:
            presentOKAlertWith(title: "Invalid Number", message: "Please use and integer for item number")
        case 2:
            presentOKAlertWith(title: "Invalid Date", message: "Please use MM/DD/YYYY format")
        case 3:
            presentOKAlertWith(title: "Invalid Location", message: "Please use latitude, longitude format")
        default:
            presentOKAlertWith(title: "Error", message: "Looks like there was an error validating your item")
            return
        }
    }

}

extension ItemModalViewController: ItemModalViewDelegate {
    
    func didSelectManageComponents(itemModalView: ItemModalView) {
        let componentsViewController = ComponentsTableViewController()
        componentsViewController.delegate = self
        let navController = UINavigationController(rootViewController: componentsViewController)
        navController.modalTransitionStyle = .crossDissolve
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated: true, completion: nil)
    }
    
        
    func didSelectCurrentLocation(itemModalView: ItemModalView) {
        let currentLocation = LocationHelper.shared.currentLocationString()
        self.itemModalView?.locationTextField.text = currentLocation
    }
    
    
    func didClose(itemModalView: ItemModalView) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSaveUpdate(itemModalView: ItemModalView) {
        let isValidCode = ItemValidator.validate(itemModalView: itemModalView)
        if isValidCode != 0 {
            handleErrorWithInvalidCode(isValidCode)
            return
        }
        if self.item != nil {
            //Update Item
            updateCurrentItem()
        } else {
            //Create New Item
            createAndSaveNewItem()
        }
        self.dismiss(animated: true, completion: nil)

    }
    
}

extension ItemModalViewController: ComponentsTableViewControllerDelegate {
    
    func didFinish(componentsTableViewController: ComponentsTableViewController) {
        let components = componentsTableViewController.components
        self.itemComponents = components
        
    }
    
    
}
