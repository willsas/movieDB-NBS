//
//  FavouriteViewModel.swift
//  movieDB-NBS
//
//  Created by Willa on 30/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FavouriteViewModel {
    
    typealias Factory = PersistenceServiceFactory
    private let factory: Factory
    
    private lazy var persistenceService: PersistenceService = factory.makeUserDefaultPersistenceService()
    
    var itemReadyToBind: BehaviorRelay<[MovieModel]>
    var rawItem: BehaviorRelay<[MovieModel]>
    
    
    init(factory: Factory) {
        self.factory = factory
        itemReadyToBind = BehaviorRelay<[MovieModel]>(value: [])
        rawItem = BehaviorRelay<[MovieModel]>(value: [])
    }
    
    
    /// Get items at
    /// - Parameter index: index path
    /// - Returns: moview model optional
    func itemsAt(index: Int) -> MovieModel?{
        return itemReadyToBind.value[safe: index]
    }
    
    
    /// Pressitence call of saved movie model
    func populateMovie(){
        if let movies = persistenceService.retriveData([MovieModel].self, forKey: .favouriteMovie){
            rawItem.accept(movies)
            itemReadyToBind.accept(movies)
        }
    }
    
    /// Query local arary of movie model
    /// - Parameter string: string query
    func query(string: String){
        if string != "" && string != " "{
            itemReadyToBind.accept(rawItem.value.filter({$0.title.lowercased().contains(string.lowercased())}))
        }else{
            itemReadyToBind.accept(rawItem.value)
        }
    }
    
    func deleteFavouriete(movie: MovieModel){
        var favMovie = persistenceService.retriveData([MovieModel].self, forKey: .favouriteMovie)
        favMovie?.removeAll(where: {$0.id == movie.id})
        persistenceService.saveData(favMovie, forKey: .favouriteMovie)
    }
}
