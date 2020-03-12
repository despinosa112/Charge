//
//  DashboardTableViewCellView.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

protocol DashboardTableViewCellViewDelegate {
    func didSelectPressShowBarcode(dashboardTableViewCellView: DashboardTableViewCellView, indexPath: IndexPath)
}

class DashboardTableViewCellView: UIView {

    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var itemDescriptionTextView: UITextView!

    @IBOutlet weak var componentCountLabel: UILabel!
    
    var indexPath: IndexPath!
    var delegate: DashboardTableViewCellViewDelegate?

    @IBOutlet weak var showBarcodeButton: UIButton!

    @IBAction func showBarcode(_ sender: Any) {
        self.delegate?.didSelectPressShowBarcode(dashboardTableViewCellView: self, indexPath: indexPath)
    }
}
