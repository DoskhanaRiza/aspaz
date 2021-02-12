//
//  MenuViewController.swift
//  AspaZ
//
//  Created by Riza on 12/23/20.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    let realm = try! Realm()
    var menus = [Menu]()
    var recipesDataModel = RecipesDataModel()    
    let collectionView = UICollectionView(frame: UIView().frame, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 2.5, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 150)
        
        collectionView.frame = self.view.frame
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - CollectionView methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 5, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        let menu = menus[indexPath.row]
        cell.menuNameLabel.text = menu.name
        cell.menuImageView.image = menu.image
    
        let name = menu.name
        if UserDefaults.standard.bool(forKey: "isSelected\(name ?? "")") {
            cell.addToFavoritesButton.setImage(UIImage(named: "heartfilled"), for: .normal)
        } else {
            cell.addToFavoritesButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let recipeVC = RecipeViewController()
        self.navigationController?.pushViewController(recipeVC, animated: true)
        let menu = menus[indexPath.row]
        recipeVC.navigationItem.title = menu.name
        recipeVC.recipeImageView.image = menu.image
        recipeVC.recipe = recipesDataModel.getRecipe(with: menu.name ?? "")
        recipeVC.recipeLabel.text = String(recipeVC.recipe!.description)
        
    }

    //MARK: - Realm methods
    
    func addToFavoritesRealm(menu: Menu) {
        do {
            try realm.write {
                realm.add(menu)
            }
        } catch {
            print("Unable to add")
        }
    }
    
}



