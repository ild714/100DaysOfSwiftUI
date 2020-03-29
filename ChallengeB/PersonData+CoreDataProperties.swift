//
//  PersonData+CoreDataProperties.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 29.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonData> {
        return NSFetchRequest<PersonData>(entityName: "PersonData")
    }

    @NSManaged public var name: String?

    public var wrappedName: String {
        name ?? "No name"
    }
}
