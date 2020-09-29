//
//  Coordinators.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var vc: UIViewController? { get set }
    var factory: ViewControllerFactory { get set }
}

struct HomeCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    var vc: UIViewController?
    
    var factory: ViewControllerFactory
    
    init(factory: ViewControllerFactory, vc: UIViewController) {
        self.vc = vc
        self.navigationController = vc.navigationController
        self.factory = factory
    }
    
    func pushToDetailViewController(movie: MovieModel, image: UIImage){
        let vc = factory.makeDetailViewController(movie: movie, image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
}

struct PopularCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    var vc: UIViewController?
    
    var factory: ViewControllerFactory
    
    init(factory: ViewControllerFactory, vc: UIViewController) {
        self.vc = vc
        self.navigationController = vc.navigationController
        self.factory = factory
    }
    func pushToDetailViewController(movie: MovieModel, image: UIImage){
        let vc = factory.makeDetailViewController(movie: movie, image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
}

struct DetailCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    var vc: UIViewController?
    
    var factory: ViewControllerFactory
    
    init(factory: ViewControllerFactory, vc: UIViewController) {
        self.vc = vc
        self.factory = factory
    }
}

