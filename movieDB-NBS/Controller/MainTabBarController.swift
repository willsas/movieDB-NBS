//
//  MainTabBarController.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    typealias Factoy = ViewControllerFactory
    
    private let factory: Factoy

 
    
    init(factory: Factoy) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        setupHomeViewController()
        setupPopularViewController()
        setupFavouriteViewController()
     }
    
    
    private func setupHomeViewController(){
        let vc = factory.makeHomeViewController()
        vc.navigationItem.title = "Home"
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        nav.tabBarItem = UITabBarItem(title: "Home", image: UIImage.houseFill, selectedImage: UIImage.houseFill)
        addChild(nav)
    }
    
    private func setupPopularViewController(){
        let vc = factory.makePopularViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = "Top Rated"
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        addChild(nav)
    }
    
    private func setupFavouriteViewController(){
        let vc = factory.makeFavouriteViewController()
        vc.navigationItem.title = "Favourite"
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        addChild(nav)
    }
    
    
    
}
