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
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //creating context
        //let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        //describe an entity we will work with
        //let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        //create manage object
        //let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        //create manage object after adding entity Person class
        //let managedObject = Person(entity: CoreDataManager.instance.entityForName("Person"), insertInto: CoreDataManager.instance.context)
        let managedObject = Person()
        
        //setting up attributes
        //managedObject.setValue("Petya", forKey: "name")
        //managedObject.setValue(18, forKey: "age")
        
        //setting up attributes after adding entity Person class
        managedObject.name = "Petya"
        managedObject.age = 14
        
        //getting values of attributes from the context
        //let name = managedObject.value(forKey: "name")
        //let age = managedObject.value(forKey: "age")
        
        //getting values of attributes from the context after adding entity Person class
        let name = managedObject.name
        let age = managedObject.age
        
        print(name, age)
        
        //saving data
        //appDelegate.saveContext()
        CoreDataManager.instance.saveContext()
        
        //getting data from data base
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            /*for result in results as! [NSManagedObject] {
                print("name - \(result.value(forKey: "name")!), age - \(result.value(forKey: "age")!)")
            }*/
            
            //getting data from data base after adding entity Person class
            for result in results as! [Person] {
                print("name - \(result.name), age - \(result.age)")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        //deleting data (whole)
        /*do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                CoreDataManager.instance.context.delete(result)
            }
        } catch {
            print(error.localizedDescription)
        }
        //saving changes again
        CoreDataManager.instance.saveContext()*/
    }
    



}

