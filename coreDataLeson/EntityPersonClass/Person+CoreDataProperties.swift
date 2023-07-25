//
//  Person+CoreDataProperties.swift
//  coreDataLeson
//
//  Created by N S on 25.07.2023.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}

extension Person : Identifiable {

}
