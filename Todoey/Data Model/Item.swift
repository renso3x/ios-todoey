//
//  Item.swift
//  Todoey
//
//  Created by Romeo Enso on 05/01/2018.
//  Copyright © 2018 Romeo Enso. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isChecked: Bool = false
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
