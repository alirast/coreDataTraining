//
//  Person+CoreDataClass.swift
//  coreDataLeson
//
//  Created by N S on 25.07.2023.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("Person"), insertInto: CoreDataManager.instance.context)
        
    }
}
