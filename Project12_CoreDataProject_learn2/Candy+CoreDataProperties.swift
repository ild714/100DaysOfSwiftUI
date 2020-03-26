//
//  Candy+CoreDataProperties.swift
//  Project12_CoreDataProject_learn2
//
//  Created by Ильдар Нигметзянов on 26.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }

}
