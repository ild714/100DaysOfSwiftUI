//
//  MKPointAnnotation-Observable.swift
//  Project14_BucketList_practice
//
//  Created by Ильдар Нигметзянов on 08.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject{
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        set {
            title = newValue
        }
    }
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        set {
            subtitle = newValue
        }
    }
}
