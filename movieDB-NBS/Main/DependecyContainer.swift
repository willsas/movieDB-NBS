//
//  DependecyContainer.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

/**
##Dependency Container
implementation of FactoryProtocol funcitonality. All of each view controller functionality, being set in here, dependency container act as a mediator or a container

- DESCRIPTION: implement all the FactoryProtocol's protocol  here, and make as a global proerties in app delegate
*/

final class DependencyContainer{
    
    private let networkService: NetworkingService
    
    init(networkService: NetworkingService) {
        self.networkService = networkService
    }
    
}

extension DependencyContainer: PersistenceServiceFactory{
    func makeUserDefault() -> PersistenceService {
        return UserDefaultPersistenceService()
    }
    
    
}


extension DependencyContainer: ViewControllerFactory{
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController()
    }
    
    func makePopularViewController() -> PopularViewController {
        return PopularViewController()
    }
    
    func makeDetailViewController(movie: MovieModel) -> DetailViewController {
        return DetailViewController()
    }
    
    
}


extension DependencyContainer :CoordinatorFactory{
    func makeHomeCoordinator(vc: UIViewController) -> HomeCoordinator {
        return HomeCoordinator(factory: self, vc: vc)
    }
    
    func makePopularCoordinator(vc: UIViewController) -> PopularCoordinator {
        return PopularCoordinator(factory: self, vc: vc)
    }
    
    func makeDetailCoordinator(vc: UIViewController) -> DetailCoordinator {
        return DetailCoordinator(factory: self, vc: vc)
    }
    
    
}

