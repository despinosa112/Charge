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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.tableView.register(DashboardTableViewCell.self, forCellReuseIdentifier: "cellId")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refresh()
    }
    
    @IBAction func add(_ sender: Any) {
        presentItemModalViewController()
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
    
    
    func presentItemModalViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let itemModalViewController: ItemModalViewController = storyboard.instantiateViewController(withIdentifier: "itemModalViewController") as! ItemModalViewController
        
        self.present(itemModalViewController, animated: true, completion: nil)
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
        // #warning Incomplete implementation, return the number of rows
        return 1
        //return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DashboardTableViewCell
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
