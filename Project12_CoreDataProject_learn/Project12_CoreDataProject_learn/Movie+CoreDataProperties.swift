//
//  Movie+CoreDataProperties.swift
//  Project12_CoreDataProject_learn
//
//  Created by Ильдар Нигметзянов on 25.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    public var wrappedTitle: String {
        return title ?? "Unknown Title"
    }
    
}
