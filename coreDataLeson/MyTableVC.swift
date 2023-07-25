//
//  MyTableVC.swift
//  coreDataLeson
//
//  Created by N S on 25.07.2023.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController {
    
    struct Constants {
        static let entity = "Person"
        //name of the attribute for sorting
        static let sortName = "name"
        static let cellName = "Cell"
        static let identifier = "tableInAddVC"
    }
    
    //manager for results of request
    //observe all the changes
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        let sortDescriptor = NSSortDescriptor(key: Constants.sortName, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultController.delegate = self
        
        do {
            //downloading data to the controller
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
        let person = fetchResultController.object(at: indexPath) as! Person
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = String(person.age)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = fetchResultController.object(at: indexPath) as! Person
        performSegue(withIdentifier: Constants.identifier, sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.identifier {
            let controller = segue.destination as! AddViewController
            controller.person = sender as? Person
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = fetchResultController.object(at: indexPath) as! Person
            CoreDataManager.instance.context.delete(person)
            CoreDataManager.instance.saveContext()
        }
    }
    
}


extension MyTableViewController: NSFetchedResultsControllerDelegate {
    //to observe changes in table view
    //inform about beginning of data changes
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //process data changes
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let person = fetchResultController.object(at: indexPath) as! Person
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = person.name
                cell?.detailTextLabel?.text = String(person.age)
            }
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    //inform about ending of data changes
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

