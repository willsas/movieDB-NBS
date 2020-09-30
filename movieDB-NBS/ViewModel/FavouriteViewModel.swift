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
    
    private lazy var userDefault: PersistenceService = factory.makeUserDefault()
    
    var itemReadyToBind: BehaviorRelay<[MovieModel]>
    var rawItem: BehaviorRelay<[MovieModel]>
    
    init(factory: Factory) {
        self.factory = factory
        itemReadyToBind = BehaviorRelay<[MovieModel]>(value: [])
        rawItem = BehaviorRelay<[MovieModel]>(value: [])
    }
    
    func itemsAt(index: Int) -> MovieModel?{
        return itemReadyToBind.value[safe: index]
    }
    
    
    func populateMovie(){
        if let movies = userDefault.retriveData([MovieModel].self, forKey: .favouriteMovie){
            rawItem.accept(movies)
            itemReadyToBind.accept(movies)
        }
    }
    
    
    func query(string: String){
        if string != "" && string != " "{
            itemReadyToBind.accept(rawItem.value.filter({$0.title.lowercased().contains(string.lowercased())}))
        }else{
            itemReadyToBind.accept(rawItem.value)
        }
    }
}
