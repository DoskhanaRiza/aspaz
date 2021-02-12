//
//  FavoritesViewController.swift
//  AspaZ
//
//  Created by Riza on 12/23/20.
//

import UIKit
import RealmSwift
import SwipeCellKit

let favoritesCellID = "FavoritesCell"

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    let recipesDataModel = RecipesDataModel()
    var favorites: Results<Favorites>?
    let realm = try! Realm()
    
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Сүйікті"
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 150
        tableView.separatorStyle = .none

        handleTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
        handleTableView()
        
    }
    
    //MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
        }
        deleteAction.image = UIImage(named: "trash")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        if let menu = favorites?[indexPath.row] {
            cell.imageView?.image = UIImage(named: menu.name ?? "milkgirl" )
            cell.textLabel?.text = menu.name
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recipeVC = RecipeViewController()
        self.navigationController?.pushViewController(recipeVC, animated: true)
        let menu = favorites?[indexPath.row]
        recipeVC.navigationItem.title = menu?.name
        recipeVC.recipeImageView.image = UIImage(named: menu?.name ?? "")
        recipeVC.recipe = recipesDataModel.getRecipe(with: menu?.name ?? "")
        recipeVC.recipeLabel.text = String(recipeVC.recipe!.description)
        
    }
    
    //MARK: - Realm methods

    func loadFavorites() {
        do {
            favorites = realm.objects(Favorites.self)
            tableView.reloadData()
        }
    }
    
    func deleteFavorites() {
        do {
            try realm.write {
                realm.delete(realm.objects(Favorites.self))
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - SwipeTableViewCell methods
    
    func updateModel(at indexPath: IndexPath) {
        
        // Passing the name of the meal to be removed from the favorites using NotificationCenter
        if let favorite = favorites?[indexPath.row] {
            let name = favorite.name
            NotificationCenter.default.post(name: Notification.Name(rawValue: "buttonState"), object: name)
            
            do {
                try realm.write {
                    realm.delete(realm.objects(Favorites.self).filter("name==%@", name ?? ""))
                }
            } catch {
                print(error)
            }
        }
       
    }
    
    //MARK: - Setting UI
    
    let emptyListLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.0431372549, blue: 0.168627451, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сүйікті тағамдар таңдалмаған.\nМәзірден таңдап алыңыз."
        return label
    }()
    
    func handleTableView() {
        if favorites?.count == 0 {
            hideTableView()
        } else {
            showTableView()
        }
    }
    
    func showTableView() {
        
        view.addSubview(emptyListLabel)
        tableView.isHidden = false
        emptyListLabel.isHidden = true
        emptyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = false
        emptyListLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = false
    }
    
    func hideTableView() {
        
        view.addSubview(emptyListLabel)
        tableView.isHidden = true
        emptyListLabel.isHidden = false
        emptyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyListLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
}    

