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
    
    /// Return MainTabBarController
    func makeMainTabBarController() -> MainTabBarController
    
    /// Return HomeViewController
    func makeHomeViewController() -> HomeViewController
    
    /// Retrun PopularViewController
    func makePopularViewController() -> PopularViewController
    
    /// Return DetailViewController
    /// - Parameters:
    ///   - movie: Choosen Movie Model
    ///   - image: paass the actual UIImage
    func makeDetailViewController(movie: MovieModel, image: UIImage) -> DetailViewController
    
    
    /// Return FavouriteViewController
    func makeFavouriteViewController() -> FavouriteViewController
}


protocol MovieServiceFactory {
    
    
    /// Request to get Banners
    /// - Parameters:
    ///   - resource: Reousrce of  BaseModel[MovieModel]
    ///   - completion: result of [MovieModel]
    func reqeuestGetBanners(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void )
    
    
    /// Request to get popular movie
    /// - Parameters:
    ///   - resource: Resource of Base model [MovieModel]
    ///   - completion: Result of [Movie Model]
    func requestGetPopularMovies(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void)
    
    
    /// Request to get coming soon movies
    /// - Parameters:
    ///   - resource: Resource of BaseModel [MovieModel]
    ///   - completion: Result of [MovieModel]
    func requestGetComingSoonMovies(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void)

}


protocol PersistenceServiceFactory {
    
    /// Return PersistenceService object based on user default
    func makeUserDefaultPersistenceService() -> PersistenceService
    
    /// Make Realm Persistence Service
//    func makeRealmPersistenceService() -> PersistenceService
    
    func makeCoreDataPersistenceService() -> PersistenceService
}

protocol CoordinatorFactory {
    
    /// Retrurn HomeCoordinator
    /// - Parameter vc: HomeViewController
    func makeHomeCoordinator(vc: UIViewController)  -> HomeCoordinator
    
    /// Retgurn PopularCoordinator
    /// - Parameter vc:PopularViewController
    func makePopularCoordinator(vc: UIViewController) -> PopularCoordinator
    
    /// Return DetailCoordinator
    /// - Parameter vc: DetailViewController
    func makeDetailCoordinator(vc: UIViewController) -> DetailCoordinator
    
    /// Retgurn FavouriteCoordinator
    /// - Parameter vc: FavouriteViewController
    func makeFavouriteCoordinator(vc: UIViewController) -> FavouriteCoordinator
}

