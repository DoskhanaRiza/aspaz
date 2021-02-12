//
//  MenuDataModel.swift
//  AspaZ
//
//  Created by Riza on 12/24/20.
//

import UIKit

struct DataModel {
    
    let cuisines = [
        Cuisine(name: "Қазақ асханасы", image: UIImage(named: "kazakh")!),
        Cuisine(name: "Қытай асханасы", image: UIImage(named: "chinese")!),
        Cuisine(name: "Түрік асханасы", image: UIImage(named: "turkish")!),
        Cuisine(name: "Итальян асханасы", image: UIImage(named: "italian")!),
        Cuisine(name: "Француз асханасы", image: UIImage(named: "french")!),
        Cuisine(name: "Жапон асханасы", image: UIImage(named: "japanese")!)
    ]
    
    let kazakhFood = [
        Menu(image: UIImage(named: "besh")!, name: "Бешбармақ"),
        Menu(image: UIImage(named: "asip")!, name: "Әсіп"),
        Menu(image: UIImage(named: "kozhe")!, name: "Көже"),
        Menu(image: UIImage(named: "baursak")!, name: "Бауырсақ"),
        Menu(image: UIImage(named: "kuyrdak")!, name: "Қуырдақ"),
        Menu(image: UIImage(named: "talkan")!, name: "Талқан")
    ]

    let turkishFood = [
        Menu(image: UIImage(named: "mercimek")!, name: "Жасымық сорпасы"),
        Menu(image: UIImage(named: "pahlava")!, name: "Пахлава"),
        Menu(image: UIImage(named: "revani")!, name: "Ревани")
    ]
    
    let italianFood = [
        Menu(image: UIImage(named: "pizza")!, name: "Пицца"),
        Menu(image: UIImage(named: "tiramisu")!, name: "Тирамису")
    ]
    
    let chineseFood = [Menu]()
    
    let japaneseFood = [Menu]()
    
    let frenchFood = [Menu]()
    
    func getMenu(with name: String) -> [Menu] {
        switch name {
        case "Қазақ асханасы":
            return kazakhFood
        case "Түрік асханасы":
            return turkishFood
        case "Қытай асханасы":
            return chineseFood
        case "Итальян асханасы":
            return italianFood
        case "Француз асханасы":
            return frenchFood
        case "Жапон асханасы":
            return japaneseFood
        default:
            return kazakhFood
        }
    }
    
    
}


