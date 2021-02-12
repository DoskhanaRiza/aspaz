//
//  MenuDataModel.swift
//  AspaZ
//
//  Created by Riza on 12/24/20.
//

import UIKit
import RealmSwift

struct DataModel {
    
    let realm = try! Realm()
    var cuisines = [Cuisine]()
    
    init() {
        
        let kazakhCuisine = Cuisine()
        kazakhCuisine.name = "Қазақ асханасы"
        kazakhCuisine.image = UIImage(named: "kazakh")!
        
        let turkishCuisine = Cuisine()
        turkishCuisine.name = "Түрік асханасы"
        turkishCuisine.image = UIImage(named: "turkish")!
        
        let chineseCuisine = Cuisine()
        chineseCuisine.name = "Қытай асханасы"
        chineseCuisine.image = UIImage(named: "chinese")!
        
        let italianCuisine = Cuisine()
        italianCuisine.name = "Итальян асханасы"
        italianCuisine.image = UIImage(named: "italian")!
        
        let frenchCuisine = Cuisine()
        frenchCuisine.name = "Француз асханасы"
        frenchCuisine.image = UIImage(named: "french")!
        
        let japaneseCuisine = Cuisine()
        japaneseCuisine.name = "Жапон асханасы"
        japaneseCuisine.image = UIImage(named: "japanese")!
        
        cuisines.append(kazakhCuisine)
        cuisines.append(turkishCuisine)
        cuisines.append(italianCuisine)
        cuisines.append(frenchCuisine)
        cuisines.append(chineseCuisine)
        cuisines.append(japaneseCuisine)
        
    }
    
    
    
    func getFood(with name: String) -> [Menu] {
        
        var kazakhFood = [Menu]()
        var turkishFood = [Menu]()
        var italianFood = [Menu]()
        let chineseFood = [Menu]()
        let japaneseFood = [Menu]()
        let frenchFood = [Menu]()
        
        let besh = Menu()
        besh.name = "Бешбармақ"
        besh.image = UIImage(named: "Бешбармақ")!
        
        let asip = Menu()
        asip.name = "Әсіп"
        asip.image = UIImage(named: "Әсіп")!
        
        let kozhe = Menu()
        kozhe.name = "Көже"
        kozhe.image = UIImage(named: "Көже")!
        
        let baursak = Menu()
        baursak.name = "Бауырсақ"
        baursak.image = UIImage(named: "Бауырсақ")!
        
        let kuyrdak = Menu()
        kuyrdak.name = "Қуырдақ"
        kuyrdak.image = UIImage(named: "Қуырдақ")!
        
        let talkan = Menu()
        talkan.name = "Талқан"
        talkan.image = UIImage(named: "Талқан")!
        
        let mercimek = Menu()
        mercimek.name = "Жасымық сорпасы"
        mercimek.image = UIImage(named: "Жасымық сорпасы")!
        
        let pahlava = Menu()
        pahlava.name = "Пахлава"
        pahlava.image = UIImage(named: "Пахлава")!
        
        let revani = Menu()
        revani.name = "Ревани"
        revani.image = UIImage(named: "Ревани")!
        
        let pizza = Menu()
        pizza.name = "Пицца"
        pizza.image = UIImage(named: "Пицца")!
        
        let tiramisu = Menu()
        tiramisu.name = "Тирамису"
        tiramisu.image = UIImage(named: "Тирамису")!
        
        kazakhFood.append(besh)
        kazakhFood.append(kozhe)
        kazakhFood.append(kuyrdak)
        kazakhFood.append(baursak)
        kazakhFood.append(talkan)
        kazakhFood.append(asip)
        
        turkishFood.append(mercimek)
        turkishFood.append(pahlava)
        turkishFood.append(revani)
        
        italianFood.append(pizza)
        italianFood.append(tiramisu)
        
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


