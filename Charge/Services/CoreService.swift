//
//  CoreService.swift
//  Charge
//
//  Created by Espinosa, Daniel on 3/9/20.
//  Copyright © 2020 Espinosa, Daniel. All rights reserved.
//

import UIKit
import CoreData

class CoreService: NSObject {
    
    enum XCObjectType: String {
        case item = "Item"
        case component = "Component"
    }

    
    static func create(xCObjectType: XCObjectType, data: [String : Any]?) -> NSManagedObject?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entityName = xCObjectType.rawValue
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else { return nil }
        let xcObject = NSManagedObject(entity: entity, insertInto: managedContext)
        if let data = data {
            for (key, value) in data {
                xcObject.setValue(value, forKey: key)
            }
        }
        return xcObject
    }
    
    static func save(_ nsManagedObject: NSManagedObject) {
        guard (UIApplication.shared.delegate as? AppDelegate) != nil else { return }
        let managedContext = nsManagedObject.managedObjectContext
        do {
            try managedContext?.save()
        } catch {
            print("ERROR: Not able to save xCObject")
        }
    }
    
    static func fetch(xCObjectType: XCObjectType, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping([NSManagedObject]?) -> ()){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entityName = xCObjectType.rawValue
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        if sortDescriptors != nil {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            let xCObjects = try managedContext.fetch(fetchRequest)
            completion(xCObjects)
        } catch {
            completion(nil)
        }
    }
    
    static func delete(xCObject: NSManagedObject){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(xCObject)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error xCObject: \(error.localizedDescription)")
        }
    }   
    

}
