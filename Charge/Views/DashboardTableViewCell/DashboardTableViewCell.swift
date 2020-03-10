//
//  DashboardTableViewCell.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    var dashboardTableViewCellView: DashboardTableViewCellView?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutDashboardCell()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layoutDashboardCell(){
        let dashboardTableViewCellView: DashboardTableViewCellView = XibHelper.loadXIB(named: "DashboardTableViewCellView", type: DashboardTableViewCellView())!
        self.dashboardTableViewCellView = dashboardTableViewCellView
        self.addSubview(dashboardTableViewCellView)
        dashboardTableViewCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        dashboardTableViewCellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        dashboardTableViewCellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        dashboardTableViewCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
}
