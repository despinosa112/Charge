//
//  ComponentsViewController.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/11/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit
import CoreData

class ComponentsTableViewController: UITableViewController {
    
    var components = [Component]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        setupNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func setupNav(){
        self.title = "Item Components"
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissSelf))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addComponent))
        self.navigationItem.setRightBarButtonItems([closeButton, addButton], animated: true)

    }

    
    @objc func addComponent(){
        let alertController = UIAlertController(title: "Add Component", message: "Please add a component name", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = ""
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (cancel) in
            //
        }
        let customAction = UIAlertAction(title: "Add", style: .default) { (add) in
            let componentName = (alertController.textFields?.first!)?.text
            self.createComponentWith(name: componentName ?? "")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(customAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createComponentWith(name: String){
        let data = [Component.Keys.name.rawValue : name] as [String : Any]
        guard let component = CoreService.create(xCObjectType: .component, data: data) as? Component else { return }
        self.components.append(component)
        self.tableView.reloadData()
    }
    
}

extension ComponentsTableViewController {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.components.count
        
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        }
        let componentViewModel = ComponentViewModel(component: self.components[indexPath.item])
        cell.textLabel?.text = componentViewModel.name
        return cell
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete  && !self.resultSearchController.isActive{
////            CoreService.delete(xCObject: self.items[indexPath.item])
////            self.refresh()
//        }
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newComponentTableViewController = ComponentsTableViewController()
        self.navigationController?.pushViewController(newComponentTableViewController, animated: true)

    }

}
