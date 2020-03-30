//
//  PersonData+CoreDataProperties.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 30.03.2020.
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
    @NSManaged public var isActive: Bool
    @NSManaged public var id: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tag: NSSet?
    @NSManaged public var friend: NSSet?

    public var wrappedName: String {
        name ?? "No name"
    }
    public var wrappedId: String {
        id ?? "No name"
    }
    public var wrappedCompany: String {
        company ?? "No name"
    }
    public var wrappedEmail: String {
        email ?? "No name"
    }
    public var wrappedAddress: String {
        address ?? "No name"
    }
    public var wrappedAbout: String {
        about ?? "No name"
    }
    public var wrappedRegistered: String {
        registered ?? "No name"
    }
    
    public var tagArray: [Tag]{
     tag?.allObjects as? [Tag] ?? [Tag]()
    }
    
    public var friendArray: [FriendData]{
     friend?.allObjects as? [FriendData] ?? [FriendData]()
    }
}

// MARK: Generated accessors for tag
extension PersonData {

    @objc(addTagObject:)
    @NSManaged public func addToTag(_ value: Tag)

    @objc(removeTagObject:)
    @NSManaged public func removeFromTag(_ value: Tag)

    @objc(addTag:)
    @NSManaged public func addToTag(_ values: NSSet)

    @objc(removeTag:)
    @NSManaged public func removeFromTag(_ values: NSSet)

}

// MARK: Generated accessors for friend
extension PersonData {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: FriendData)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: FriendData)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
