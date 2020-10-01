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

extension DependencyContainer{
    
    /// Handle network response from all over networking request
    /// - Parameters:
    ///   - response: Response result of Basemodel of those generic type
    ///   - completion: Result completion of generic type
    private func handleNetworkResponse<T>(_ response: Result<BaseModel<T>, NetworkingError>, completion: @escaping (Result<T, NetworkingError>) -> Void){
        switch response {
        case .success(let result):
            
            if let data = result.results{
                completion(.success(data))
            }else{
                completion(.failure(NetworkingError.other("Error: no data!")))
            }
            
        case .failure(let err):
            completion(.failure(NetworkingError.err(err)))
        }
    }
}



extension DependencyContainer: PersistenceServiceFactory{

    
    func makeUserDefaultPersistenceService() -> PersistenceService {
        return UserDefaultPersistenceService()
    }
    
//    func makeRealmPersistenceService() -> PersistenceService {
//        return RealmPersistenceService()
//    }
    
    func makeCoreDataPersistenceService() -> PersistenceService {
        return CoreDataPersistenceService()
    }
    
    
}


extension DependencyContainer: ViewControllerFactory{
    
    
    func makeMainTabBarController() -> MainTabBarController {
        return MainTabBarController(factory: self)
    }
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController(factory: self)
    }
    
    func makePopularViewController() -> PopularViewController {
        return PopularViewController(factory: self)
    }
    
    
    func makeDetailViewController(movie: MovieModel, image: UIImage) -> DetailViewController {
        return DetailViewController(factory: self, movie: movie, image: image)
    }
    
    func makeFavouriteViewController() -> FavouriteViewController {
        return FavouriteViewController(factory: self)
    }
    
    
}

extension DependencyContainer: MovieServiceFactory{
    
    func reqeuestGetBanners(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void) {
        networkService.perform(resource: resource) { [weak self] (response) in
            self?.handleNetworkResponse(response, completion: completion)
        }
    }
    
    func requestGetPopularMovies(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void) {
        networkService.perform(resource: resource) { [weak self] (response) in
            self?.handleNetworkResponse(response, completion: completion)
        }
    }
    
    func requestGetComingSoonMovies(resource: Resource<BaseModel<[MovieModel]>>, completion: @escaping (Result<[MovieModel], NetworkingError>) -> Void) {
        networkService.perform(resource: resource) { [weak self] (response) in
            self?.handleNetworkResponse(response, completion: completion)
        }
    }
    
    
}


extension DependencyContainer :CoordinatorFactory{
    func makeFavouriteCoordinator(vc: UIViewController) -> FavouriteCoordinator {
        return FavouriteCoordinator(factory: self, vc: vc)
    }
    
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

