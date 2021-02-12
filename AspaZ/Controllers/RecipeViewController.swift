//
//  RecipeViewController.swift
//  AspaZ
//
//  Created by Riza on 12/24/20.
//

import UIKit
import RealmSwift

class RecipeViewController: UIViewController {

    let recipes = [RecipesDataModel]()
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()

    }
    
    //MARK: - Setting UI
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recipeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        
        // Automatically finding out the height of the recipe label
        let width = view.frame.width
        let height = recipeLabel.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        view.addSubview(scrollView)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height + recipeImageView.frame.height)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(recipeImageView)
        scrollView.addSubview(recipeLabel)
        recipeImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        recipeImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        recipeImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        recipeLabel.frame = CGRect(x: 5, y: 150, width: scrollView.frame.width - 5, height: height)
        recipeLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20).isActive = true
        recipeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        recipeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 8).isActive = true
        recipeLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
        
    }
    
}
