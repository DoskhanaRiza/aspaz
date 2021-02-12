//
//  MenuCell.swift
//  AspaZ
//
//  Created by Riza on 12/24/20.
//

import UIKit
import RealmSwift

class MenuCell: UICollectionViewListCell {
    
    let realm = try! Realm()
    static let identifier = "MenuCell"
    let likedMenu = Favorites()
    var observer: NSObjectProtocol?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setting UI
    
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let menuNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let addToFavoritesButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    func setupViews() {
        
        contentView.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.0431372549, blue: 0.168627451, alpha: 1)
        contentView.addSubview(menuImageView)
        contentView.addSubview(menuNameLabel)
        contentView.addSubview(addToFavoritesButton)
        
        menuImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        menuNameLabel.frame = CGRect(x: 15, y: menuImageView.frame.height - 25, width: 170, height: 16)
        menuNameLabel.textAlignment = .left
        
        addToFavoritesButton.frame = CGRect(x: contentView.frame.width - 30, y: menuImageView.frame.height - 170, width: 25, height: 25)
        addToFavoritesButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        addToFavoritesButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        addToFavoritesButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        addToFavoritesButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        
    }
    
    //MARK: - Handling like button
    
    @objc func addToFavorites(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        // changing the state of the button when removed from favorites
        observer = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "buttonState"), object: nil, queue: .main, using: { [self] notification in
            guard let object = notification.object as? String else {
                return
            }

            if self.menuNameLabel.text == object {
                sender.setImage(UIImage(named: "heart"), for: .normal)
                UserDefaults.standard.setValue(false, forKey: "isSelected\(self.menuNameLabel.text ?? "")")
            }

        })
        
        // changing the state of the button when like pressed
        
        if sender.isSelected == true {
            addToFavoritesRealm(menu: likedMenu)
            sender.setImage(UIImage(named: "heartfilled"), for: .normal)
            UserDefaults.standard.setValue(sender.isSelected, forKey: "isSelected\(menuNameLabel.text ?? "")")
        } else {
            removeFromFavorites(menu: likedMenu)
            sender.setImage(UIImage(named: "heart"), for: .normal)
            UserDefaults.standard.setValue(false, forKey: "isSelected\(menuNameLabel.text ?? "")")
            
        }
    }
    
    //MARK: - Realm methods
    
    func addToFavoritesRealm(menu: Favorites) {
        do {
            try realm.write {
                menu.name = menuNameLabel.text
                realm.create(Favorites.self, value: menu, update: .modified)
            }
        } catch {
            print("Unable to add")
        }
    }
    
    func removeFromFavorites(menu: Favorites) {
        do {
            try realm.write {
                menu.name = menuNameLabel.text
                realm.delete(realm.objects(Favorites.self).filter("name==%@", menuNameLabel.text ?? ""))
            }
        } catch {
            print(error)
        }
    }
    
}

