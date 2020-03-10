//
//  ViewController.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let modalOverlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutModalOverlay()
    }
    
    func layoutModalOverlay(){
        self.view.addSubview(modalOverlay)
        modalOverlay.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        modalOverlay.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        modalOverlay.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        modalOverlay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }


}

