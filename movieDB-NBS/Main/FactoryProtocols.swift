//
//  FactoryProtocols.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

/**
##FACTORY PROTOCOL
factory protocol is one of the approach of protocol oriented programming and dependecy injections.  in order to  make code tetstable and less decouple

- DESCRIPTION: All the functionality, network request, class dependecies, custom class dependencies, put it as a protocol here

- SOURCE:  [dependecy injection ]  https://www.swiftbysundell.com/articles/dependency-injection-using-factories-in-swift/
*/

protocol ViewControllerFactory{
    
    func makeMainTabBarController() -> MainTabBarController
    
    func makeHomeViewController() -> HomeViewController
    
    func makePopularViewController() -> PopularViewController
    
    func makeDetailViewController(movie: MovieModel, image: UIImage) -> DetailViewController
    
    func makeFavouriteViewController() -> FavouriteViewController
}


protocol MovieServiceFactory {

    func requsestGetMovies(resource: Resource<MovieModel>, completion: @escaping (Result<MovieModel, NetworkingError>) -> Void)
    
    func reqeuestGetBanners(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void )
    
    func requestGetPopularMovies(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void)
    
    func requestGetComingSoonMovies(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void)

}


protocol PersistenceServiceFactory {
    
    /// Return PersistenceService object based on user default
    func makeUserDefault() -> PersistenceService
}

protocol CoordinatorFactory {
    
    func makeHomeCoordinator(vc: UIViewController)  -> HomeCoordinator
    
    func makePopularCoordinator(vc: UIViewController) -> PopularCoordinator
    
    func makeDetailCoordinator(vc: UIViewController) -> DetailCoordinator
    
    func makeFavouriteCoordinator(vc: UIViewController) -> FavouriteCoordinator
}

