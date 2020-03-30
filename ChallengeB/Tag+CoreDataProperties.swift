//
//  Tag+CoreDataProperties.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 30.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String?
    @NSManaged public var person: PersonData?

    public var wrappedName: String {
        name ?? "No name"
    }
}
