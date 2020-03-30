//
//  FriendData+CoreDataProperties.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 30.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//
//

import Foundation
import CoreData


extension FriendData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendData> {
        return NSFetchRequest<FriendData>(entityName: "FriendData")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var person: PersonData?

    public var wrappedName: String {
        name ?? "No name"
    }
    
    public var wrappedId: String {
        id ?? "No id"
    }
}
