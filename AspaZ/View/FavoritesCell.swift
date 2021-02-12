//
//  FavoritesCell.swift
//  AspaZ
//
//  Created by Riza on 12/25/20.
//

import UIKit
import RealmSwift
import SwipeCellKit

class FavoritesCell: SwipeTableViewCell {
    
    static let identifier = "FavoriteCell"
    
    override init(style: SwipeTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setting UI
    
    let menuImageView: UIImageView = {
        let menuImageView = UIImageView()
        menuImageView.layer.masksToBounds = true
        menuImageView.contentMode = .scaleAspectFill
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        return menuImageView
    }()
    
    let menuNameLabel: UILabel = {
        let namelabel = UILabel()
        namelabel.numberOfLines = 1
        namelabel.textColor = .white
        namelabel.textAlignment = .center
        namelabel.font = UIFont.systemFont(ofSize: 16)
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        return namelabel
    }()
    
    override func layoutSubviews() {

        imageView?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        imageView?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        
        imageView?.contentMode = .scaleAspectFill
        imageView?.layer.masksToBounds = true
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.clipsToBounds = true
        
        textLabel?.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35).isActive = true
        textLabel?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        textLabel?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        textLabel?.numberOfLines = 1
        textLabel?.textColor = .white
        textLabel?.textAlignment = .left
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        textLabel?.translatesAutoresizingMaskIntoConstraints = false

    }
    
}
