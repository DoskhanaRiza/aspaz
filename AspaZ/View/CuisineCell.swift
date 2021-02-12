//
//  CuisineCell.swift
//  AspaZ
//
//  Created by Riza on 12/24/20.
//

import UIKit

class CuisineCell: UITableViewCell {
    
    static let identifier = "MenuCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cuisineImageView)
        contentView.addSubview(cuisineLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setting UI
    
    let cuisineLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    let cuisineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cuisineImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height - 5)
        cuisineLabel.center = contentView.center
        cuisineLabel.frame = CGRect(x: contentView.center.x - cuisineLabel.frame.width / 2, y: contentView.center.y - 20, width: 300, height: 35)
        
    }
    
}
