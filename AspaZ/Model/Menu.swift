//
//  Menu.swift
//  AspaZ
//
//  Created by Riza on 12/24/20.
//

import UIKit
import RealmSwift

class Menu: Object {
    var image: UIImage?
    @objc dynamic var name: String?
    @objc dynamic var liked: Bool = false
}


