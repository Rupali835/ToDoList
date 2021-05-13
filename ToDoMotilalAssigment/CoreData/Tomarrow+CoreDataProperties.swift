//
//  Tomarrow+CoreDataProperties.swift
//  ToDoMotilalAssigment
//
//  Created by Rupali Patil on 12/05/21.
//  Copyright © 2021 63moons. All rights reserved.
//
//

import Foundation
import CoreData


extension Tomarrow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tomarrow> {
        return NSFetchRequest<Tomarrow>(entityName: "Tomarrow")
    }

    @NSManaged public var taskDescription: String?
    @NSManaged public var taskName: String?

}
