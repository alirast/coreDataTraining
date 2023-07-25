//
//  ViewController.swift
//  coreDataLeson
//
//  Created by N S on 25.07.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //link to the delegate (App delegate)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //creating context
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        //describe an entity we will work with
        let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        //create manage object
        let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        //setting up attributes
        managedObject.setValue("Petya", forKey: "name")
        managedObject.setValue(18, forKey: "age")
        
        //getting values of attributes from the context
        let name = managedObject.value(forKey: "name")
        let age = managedObject.value(forKey: "age")
        print(name, age)
        
        //saving data
        appDelegate.saveContext()
        
        //getting data from data base
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                print("name - \(result.value(forKey: "name")!), age - \(result.value(forKey: "age")!)")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        //deleting data (whole)
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                context.delete(result)
            }
        } catch {
            print(error.localizedDescription)
        }
        //saving changes again
        appDelegate.saveContext()
    }
    



}

