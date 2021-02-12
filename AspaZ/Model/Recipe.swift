//
//  Recipe.swift
//  AspaZ
//
//  Created by Riza on 12/24/20.
//

import Foundation

struct Recipe: CustomStringConvertible {
    let name: String
    let recipe: String
    
    var description: String {
        return "\(recipe)"
    }
}
