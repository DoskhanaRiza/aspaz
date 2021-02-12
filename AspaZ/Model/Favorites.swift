//
//  Favorites.swift
//  AspaZ
//
//  Created by Riza on 12/31/20.
//

import UIKit
import RealmSwift

class Favorites: Object {
    var image: UIImage?
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
