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
        
        let favMoviewIDs = userDefault.retriveData([MovieModel].self, forKey: .favouriteMovie)
        
        // initial
        if favMoviewIDs == nil{
            userDefault.saveData([MovieModel](), forKey: .favouriteMovie)
        }
        
        favMoviewIDs?.contains(where: {$0.id == movie.id}) == true ? isFavouriteBinder.accept(true) : isFavouriteBinder.accept(false)
        
        
    }
    
    
    
    private func saveToFavourite(){
        var favMovie = userDefault.retriveData([MovieModel].self, forKey: .favouriteMovie)
        favMovie?.contains(where: {$0.id == movie.id}) == true ? nil : favMovie?.append(movie)
        userDefault.saveData(favMovie, forKey: .favouriteMovie)
    }
    
    
    private func deleteFavouriete(){
        var favMovie = userDefault.retriveData([MovieModel].self, forKey: .favouriteMovie)
        favMovie?.removeAll(where: {$0.id == movie.id})
        userDefault.saveData(favMovie, forKey: .favouriteMovie)
    }
    
    
}
