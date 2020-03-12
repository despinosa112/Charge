//
//  DashboardControllerTableViewController.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit
import CoreData

class DashboardTableViewController: UITableViewController {
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var items = [NSManagedObject]()
    
    var filteredItems = [NSManagedObject]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: "cellId")
        addObserver(.saveNewItem)
        addObserver(.updateItem)
        LocationHelper.shared.requestAuthorization()
        self.setupSearchBar()
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.tableView.separatorStyle = .none;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refresh()
    }
    
    @IBAction func add(_ sender: Any) {
        presentItemModalViewController(item: nil)
    }
    

    func refresh(){
        let sortDescriptor = NSSortDescriptor(key: Item.Keys.date.rawValue, ascending: false)
        let sortDescriptors = [sortDescriptor]
        CoreService.fetch(xCObjectType: .item, predicate: nil, sortDescriptors: sortDescriptors) { (items) in
            if items == nil {
                self.items = [NSManagedObject]()
                self.tableView.reloadData()
                return
            }
            self.items = items!
            self.tableView.reloadData()
        }
    }
    
    
    func presentItemModalViewController(item: Item?){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let itemModalViewController: ItemModalViewController = storyboard.instantiateViewController(withIdentifier: "itemModalViewController") as! ItemModalViewController
        itemModalViewController.item = item
        self.present(itemModalViewController, animated: true, completion: nil)
    }
    
    override func didObserveNotification(notification: NSNotification) {
        let notification = NotificationHelper.Notification.init(rawValue: notification.name.rawValue)
        switch notification {
        case .saveNewItem:
            refresh()
        case .updateItem:
            refresh()
        case .none:
            print("none")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

//TableViewFunctions
extension DashboardTableViewController {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive {
            return filteredItems.count
        } else {
            return items.count
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DashboardTableViewCell
        var itemViewModel: ItemViewModel!
        if (resultSearchController.isActive) {
            itemViewModel = ItemViewModel(item: self.filteredItems[indexPath.item] as! Item)
        } else {
            itemViewModel = ItemViewModel(item: self.items[indexPath.item] as! Item)
        }
        cell.dashboardTableViewCellView?.dateLabel.text = itemViewModel.dateString
        cell.dashboardTableViewCellView?.itemDescriptionTextView.text = itemViewModel.description
        cell.dashboardTableViewCellView?.itemNumberLabel.text = itemViewModel.itemNum
        cell.dashboardTableViewCellView?.locationLabel.text = itemViewModel.locationString
        cell.dashboardTableViewCellView?.componentCountLabel.text = itemViewModel.componentCountString
        cell.dashboardTableViewCellView?.indexPath = indexPath
        cell.dashboardTableViewCellView?.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  && !self.resultSearchController.isActive{
            CoreService.delete(xCObject: self.items[indexPath.item])
            self.refresh()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultSearchController.isActive {
            resultSearchController.dismiss(animated: false) {
                let itemID = self.filteredItems[indexPath.item].objectID
                for item in self.items {
                    if item.objectID == itemID {
                        self.presentItemModalViewController(item: item as? Item)
                    }
                }
            }
        } else {
            guard let item = items[indexPath.item] as? Item else { return }
            self.presentItemModalViewController(item: item)
        }
    }

}

extension DashboardTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredItems.removeAll(keepingCapacity: false)
        let items = self.items as! [Item]
        self.filteredItems = items.filter { (item) -> Bool in
            let searchText = searchController.searchBar.text!.lowercased()
            let description = item.itemDescription!.lowercased()
            if searchText == "" {
                return true
            }
            return description.contains(searchText)
        }
        
        self.tableView.reloadData()
    }
    
    func setupSearchBar(){
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.obscuresBackgroundDuringPresentation = false
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
}

extension DashboardTableViewController: DashboardTableViewCellViewDelegate {
    
    func didSelectPressShowBarcode(dashboardTableViewCellView: DashboardTableViewCellView, indexPath: IndexPath) {
        let barcodeDisplayViewController = BarcodeDisplayViewController()
        barcodeDisplayViewController.set(item: self.items[indexPath.item] as! Item)
        let navController = UINavigationController(rootViewController: barcodeDisplayViewController)
        self.present(navController, animated: true, completion: nil)

    }

}
