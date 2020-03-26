//
//  FilteredList.swift
//  Project12_CoreDataProject_learn
//
//  Created by Ильдар Нигметзянов on 26.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T:NSManagedObject,Content:View>: View {
    
    var fetchRequest : FetchRequest<T>
    var singers: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    let content: (T) -> Content
    
    init(filterKey: String,filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey,filterValue))
        self.content = content
    }
    
   
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self){ singer in
            self.content(singer)
        }
    }
}


