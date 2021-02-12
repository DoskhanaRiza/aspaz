//
//  ViewController.swift
//  AspaZ
//
//  Created by Riza on 12/21/20.
//

import UIKit
import RealmSwift

class CuisinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    var dataModel = DataModel()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CuisineCell.self, forCellReuseIdentifier: CuisineCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Әлем асханалары"
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.alwaysBounceVertical = true
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        
        
    }
    
    //MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.cuisines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CuisineCell.identifier, for: indexPath) as? CuisineCell {
            let menu = dataModel.cuisines[indexPath.row]
            cell.cuisineLabel.text = menu.name
            cell.cuisineImageView.image = menu.image
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let menuVC = MenuViewController()
        self.navigationController?.pushViewController(menuVC, animated: true)
        let name = dataModel.cuisines[indexPath.row].name
        menuVC.menus = dataModel.getFood(with: name)
        menuVC.navigationItem.title = name
        
    }

}


