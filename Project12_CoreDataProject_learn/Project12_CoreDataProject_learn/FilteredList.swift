//
//  FilteredList.swift
//  Project12_CoreDataProject_learn
//
//  Created by Ильдар Нигметзянов on 26.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import CoreData

enum Predict {
    case beginsWith
    case lover
}

struct FilteredList<T:NSManagedObject,Content:View>: View {
    
    var fetchRequest : FetchRequest<T>
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    let content: (T) -> Content
    
    init(filterKey: String,filterValue: String,predict:Predict, @ViewBuilder content: @escaping (T) -> Content) {
        
        let predictRes : String
        switch predict {
        case .beginsWith:
            predictRes = "beginsWith"
        default:
            predictRes = "<"
        }
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Singer.firstName, ascending: true),NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)], predicate: NSPredicate(format: "%K \(predictRes) %@", filterKey,filterValue))
        self.content = content
    }
    
   
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self){ singer in
            self.content(singer)
        }
    }
}


