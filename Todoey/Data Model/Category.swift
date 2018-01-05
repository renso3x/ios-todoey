//
//  Category.swift
//  Todoey
//
//  Created by Romeo Enso on 05/01/2018.
//  Copyright © 2018 Romeo Enso. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    var items = List<Item>()
}
