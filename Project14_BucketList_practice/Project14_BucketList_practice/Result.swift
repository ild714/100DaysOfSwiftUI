//
//  Result.swift
//  Project14_BucketList_practice
//
//  Created by Ильдар Нигметзянов on 08.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int:Page]
}

struct Page: Codable, Comparable{
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}
