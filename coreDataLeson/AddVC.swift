//
//  AddVC.swift
//  coreDataLeson
//
//  Created by N S on 25.07.2023.
//

import UIKit

class AddViewController: UIViewController {
    
    var person: Person?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //reading object
        if let person = person {
            nameTextField.text = person.name
            ageTextField.text = String(person.age)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        if savePerson() {
            dismiss(animated: true)
        }
    }
    
    func savePerson() -> Bool {
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Warning", message: "Text field is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            return false
        }
        
        //creating an object
        if person == nil {
            person = Person()
        }
        
        //saving the object
        if let person = person {
            person.name = nameTextField.text
            person.age = Int16(ageTextField.text!)!
            CoreDataManager.instance.saveContext()
        }
        return true
    }
    
    
}
