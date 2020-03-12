//
//  BarcodeDisplayViewController.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class BarcodeDisplayViewController: ViewController {
    
    var barcodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()

    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black
        self.title = "Item Barcode"
        let rightBarButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissSelf))
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
        layoutBarcodeImageView()
    }
    
    func layoutBarcodeImageView(){
        self.view.addSubview(barcodeImageView)
        barcodeImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        barcodeImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        barcodeImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        barcodeImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
    }
    
    func set(item: Item){
        self.item = item
        let barcodeImage = BarcodeHelper.generateBarcode(from: item.objectID.uriRepresentation().absoluteString)
        self.barcodeImageView.image = barcodeImage
    }
    


}
