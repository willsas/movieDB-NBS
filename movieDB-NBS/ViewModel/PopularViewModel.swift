//
//  PopularViewModel.swift
//  movieDB-NBS
//
//  Created by Willa on 30/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

protocol PopularViewModelDelegate: class {
    func onError(title: String, subtitle: String)
    func onReloadData()
    func onPushToDetail(movie: MovieModel, image: UIImage)
}

class PopularViewModel: NSObject {
    
    typealias Factory = MovieServiceFactory
    private let factory: Factory
    private let cellID = String(describing: PopularCollectionViewCell.self)
    
    //raw
    private var items: [MovieModel] = []
    
    //to display
    private var itemToDisplay: [MovieModel]  = []{
        didSet{
            delegate?.onReloadData()
        }
    }
    
    
    weak var delegate: PopularViewModelDelegate?
    
    init(factory: Factory) {
        self.factory = factory
    }
    
    
    func requestPopularMovie(){
        factory.requestGetPopularMovies(resource: MovieModel.popularMoviesReource()) { [weak self] (response) in
            switch response{
            case .success(let result):
                self?.items = result
                self?.itemToDisplay = result
            case .failure(let err):
                self?.delegate?.onError(title: "Error", subtitle: err.localizedDescription)
            }
        }
    }
    
    
    
    func queryWith(string: String){
        if string != "" && string != " "{
            itemToDisplay = items.filter {$0.title.lowercased().contains(string.lowercased())}
        }else{
            itemToDisplay = items
        }
    }
    
    
    func movieAt(indexPath: IndexPath) -> MovieModel? {
        return itemToDisplay[safe: indexPath.row]
    }
    
    

}



extension PopularViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PopularCollectionViewCell,
            let item = itemToDisplay[safe: indexPath.item]{
            cell.item = item
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
