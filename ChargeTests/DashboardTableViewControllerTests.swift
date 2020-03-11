//
//  DashboardTableViewControllerTests.swift
//  ChargeTests
//
//  Created by Espinosa, Daniel on 3/10/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import XCTest
import CoreData
@testable import Charge

class DashboardTableViewControllerTests: XCTestCase {
    
    var dashboardTableViewController: DashboardTableViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        clearItemData()
        saveItemData()
        self.dashboardTableViewController = DashboardTableViewController()
        self.dashboardTableViewController.refresh()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_refresh_itemCount2(){
        self.dashboardTableViewController.refresh()
        XCTAssertEqual(2, self.dashboardTableViewController.items.count)
    }
    
    func test_viewWillAppear_refreshes(){
        self.dashboardTableViewController.viewWillAppear(true)
        XCTAssertEqual(2, self.dashboardTableViewController.items.count)
    }
    
    
    func test_searchFilter_testReturns1result(){
        self.dashboardTableViewController.refresh()
        let searchController = self.dashboardTableViewController.resultSearchController
        searchController.searchBar.text = "test"
        self.dashboardTableViewController.updateSearchResults(for: searchController)
        let filteredResults = self.dashboardTableViewController.filteredItems
        XCTAssertEqual(1, filteredResults.count)
    }
    
    func test_searchFilter_TESTReturns1result(){
        self.dashboardTableViewController.refresh()
        let searchController = self.dashboardTableViewController.resultSearchController
        searchController.searchBar.text = "TEST"
        self.dashboardTableViewController.updateSearchResults(for: searchController)
        let filteredResults = self.dashboardTableViewController.filteredItems
        XCTAssertEqual(1, filteredResults.count)
    }
    
    func test_searchFilter_emptyReturns2results(){
        let searchController = self.dashboardTableViewController.resultSearchController
        searchController.searchBar.text = ""
        self.dashboardTableViewController.updateSearchResults(for: searchController)
        let filteredResults = self.dashboardTableViewController.filteredItems
        XCTAssertEqual(2, filteredResults.count)
    }
    
    func test_numberOfRows_searchBarInactive(){
        self.dashboardTableViewController.resultSearchController.isActive = false
        let numberOfRows = self.dashboardTableViewController.tableView(self.dashboardTableViewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(2, numberOfRows)
    }
    
    

}
