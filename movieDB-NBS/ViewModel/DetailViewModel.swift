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
    
    private lazy var userDefault: PersistenceService = factory.makeUserDefault()
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
    
    
    private func isFavouriteMovie(){
        
        //        isFavouriteBinder.subscribe(onNext: { [unowned self] value in
        //            if value{
        //                self.saveToFavourite()
        //            }else{
        //                self.deleteFavouriete()
        //            }
        //        }).disposed(by: disposeBag)
        //
        //
        
        let favMoviewIDs = userDefault.retriveData([Int].self, forKey: .favouriteMovieIDs)
        
        // initial
        if favMoviewIDs == nil{
            userDefault.saveData([Int](), forKey: .favouriteMovieIDs)
        }
        
        favMoviewIDs?.contains(movie.id) == true ? isFavouriteBinder.accept(true) : isFavouriteBinder.accept(false)
        
        
    }
    
    
    
    private func saveToFavourite(){
        var favMoviewIDs = userDefault.retriveData([Int].self, forKey: .favouriteMovieIDs)
        favMoviewIDs?.contains(movie.id) == true ? nil : favMoviewIDs?.append(movie.id)
        userDefault.saveData(favMoviewIDs, forKey: .favouriteMovieIDs)
    }
    
    
    private func deleteFavouriete(){
        var favMoviewIDs = userDefault.retriveData([Int].self, forKey: .favouriteMovieIDs)
        favMoviewIDs?.removeAll(where: {$0 == movie.id})
        userDefault.saveData(favMoviewIDs, forKey: .favouriteMovieIDs)
    }
    
    
}
