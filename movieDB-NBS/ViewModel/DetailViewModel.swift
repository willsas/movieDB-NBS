//
//  DetailViewModel.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    typealias Factory = PersistenceServiceFactory
    private let factory: Factory
    
    private lazy var persistenceService: PersistenceService = factory.makeUserDefaultPersistenceService()
    private var movie: MovieModel
    private var disposeBag = DisposeBag()
    
    var isFavouriteBinder = BehaviorRelay<Bool>(value: false)
    var titleBinder: BehaviorRelay<String>
    var subtitleBinder: BehaviorRelay<String>
    var imageBinder: BehaviorRelay<UIImage>
    
    
    
    init(factory: Factory, movie: MovieModel, image: UIImage) {
        self.factory = factory
        self.movie = movie
        titleBinder = BehaviorRelay<String>(value: movie.title)
        subtitleBinder = BehaviorRelay<String>(value: movie.overview)
        imageBinder = BehaviorRelay<UIImage>(value: image)
        
        isFavouriteMovie()
    }
    
    
    // MARK: - Function for Controller
    
    /// Toggle favourite when favourite button tapped
    func toggleIsFav(){
        
        var curentValue = isFavouriteBinder.value
        curentValue.toggle()
        isFavouriteBinder.accept(curentValue)
        
        if curentValue{
            saveToFavourite()
        }else{
            deleteFavouriete()
        }
        
    }
    
    
    // MARK: - Private Function
    
    private func isFavouriteMovie(){
        
        let favMoviewIDs = persistenceService.retriveData([MovieModel].self, forKey: .favouriteMovie)
        
        // initial
        if favMoviewIDs == nil{
            persistenceService.saveData([MovieModel](), forKey: .favouriteMovie)
        }
        
        favMoviewIDs?.contains(where: {$0.id == movie.id}) == true ? isFavouriteBinder.accept(true) : isFavouriteBinder.accept(false)
        
        
    }
    
    
    /// Save favourite to persistence service
    private func saveToFavourite(){
        var favMovie = persistenceService.retriveData([MovieModel].self, forKey: .favouriteMovie)
        favMovie?.contains(where: {$0.id == movie.id}) == true ? nil : favMovie?.append(movie)
        persistenceService.saveData(favMovie, forKey: .favouriteMovie)
    }
    
    
    /// delete favourite to persistence service
    private func deleteFavouriete(){
        var favMovie = persistenceService.retriveData([MovieModel].self, forKey: .favouriteMovie)
        favMovie?.removeAll(where: {$0.id == movie.id})
        persistenceService.saveData(favMovie, forKey: .favouriteMovie)
    }
    
    
}
