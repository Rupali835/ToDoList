//
//  UpComing+CoreDataProperties.swift
//  ToDoMotilalAssigment
//
//  Created by Rupali Patil on 12/05/21.
//  Copyright © 2021 63moons. All rights reserved.
//
//

import Foundation
import CoreData


extension UpComing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UpComing> {
        return NSFetchRequest<UpComing>(entityName: "UpComing")
    }

    @NSManaged public var taskDescription: String?
    @NSManaged public var taskName: String?

}
