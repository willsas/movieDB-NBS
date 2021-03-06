//
//  HomeViewModel.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit


protocol HomeViewModelDelegate: class {
    func onReloadData()
    func onError(title: String, subtitle: String)
    func onNeedToDetailViewController(movie: MovieModel, image: UIImage)
    
}


class HomeViewModel: NSObject {
    
    typealias Factory = MovieServiceFactory
    private let factory: Factory
    private var items = [HomeViewModelItem]()
    
    
    weak var delegate: HomeViewModelDelegate?
    
    init(factory: Factory) {
        self.factory = factory
        super.init()
        
        items.insert(HomeBannerViewModel(items: [String]()), at: 0)
        items.insert(HomePopularMoviesViewModel(items: [MovieModel]()), at: 1)
        items.insert(HomeComingSoonMoviesViewModel(items: [MovieModel]()), at: 2)
    }
    
    
    // MARK: - Functino for ViewController
    
    
    /// Netowrk call Requst Banner
    func requestToFetchBanner(){
        factory.reqeuestGetBanners(resource: MovieModel.bannerReource()) { [weak self] (response) in
            switch response{
            case .success(let result):
                self?.populateNewBanner(result)
            case .failure(let err):
                self?.delegate?.onError(title: "Error get Banner", subtitle: err.localizedDescription)
            }
        }
    }
    
    
    /// Network call request popular movies
    func reqeustToFetchPopularMovies(){
        factory.requestGetPopularMovies(resource: MovieModel.popularMoviesReource()) { [weak self] (response) in
            switch response{
            case .success(let result):
                self?.populateNewPopularMovies(result)
            case .failure(let err):
                self?.delegate?.onError(title: "Error Get Popular Movies", subtitle: err.localizedDescription)
            }
        }
    }
    
    
    /// Network call request to cooming soon movies
    func requestToFetchCommingSoonMovies(){
        factory.requestGetComingSoonMovies(resource: MovieModel.comingSoonResource()) { [weak self] (response) in
            switch response{
            case .success(let result):
                self?.populateNewComingSoon(result)
            case .failure(let err):
                self?.delegate?.onError(title: "Error get Coming Soon Movies", subtitle: err.localizedDescription)
            }
        }
    }
    
       
    //    func moviesAt(indexPath: IndexPath) -> MovieModel{
    //
    //    }
    //
        
    
    
    
    // MARK: - Private function
    
    
    /// Populate Banner or change the banner view model item
    /// - Parameter movies: array of movies
    private func populateNewBanner(_ movies: [MovieModel]){
        items.removeAll(where: {$0.type == .banner})
        let posterPaths = movies.map {$0.posterPath}
        items.insert(HomeBannerViewModel(items: posterPaths), at: 0)
        delegate?.onReloadData()
    }
    
    
    /// Populate the HomePopularMovies item or Change  HomePopularMoviesViewModel
    /// - Parameter movies: array of movies
    private func populateNewPopularMovies(_ movies: [MovieModel]){
        items.removeAll(where: {$0.type == .popular})
        items.insert(HomePopularMoviesViewModel(items: movies), at: 1)
        delegate?.onReloadData()
    }
    
    
    /// Populate the HomeCoomingSoonMoviesViewModel items or change  HomeCoomingSoonMoviesViewModel
    /// - Parameter movies: array of movie
    private func populateNewComingSoon(_ movies: [MovieModel]){
         items.removeAll(where: {$0.type == .comingSoon})
         items.insert(HomeComingSoonMoviesViewModel(items: movies), at: 2)
         delegate?.onReloadData()
     }
    
    
 
}

extension HomeViewModel: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let item = items[safe: indexPath.row]{
            switch item.type {
                
            case .banner:
                
                if let cell = tableView.dequeueReusableCell(BannerTableViewCell.self),
                    let vm = item as? HomeBannerViewModel{
                    cell.vm = vm
                    return cell
                }
                
            case .popular:
                
                
                if let cell = tableView.dequeueReusableCell(HomeMovieTableViewCell.self),
                    let vm = item as? HomePopularMoviesViewModel{
                    cell.popularItems = vm
                    cell.onSelectedMovie = { [unowned self] (movie, image) in
                        self.delegate?.onNeedToDetailViewController(movie: movie, image: image)
                    }
                    return cell
                }
                

                
            case .comingSoon:
                
                if let cell = tableView.dequeueReusableCell(HomeMovieTableViewCell.self),
                    let vm = item as? HomeComingSoonMoviesViewModel{
                    cell.comingSoonItems = vm
                    cell.onSelectedMovie = { [unowned self] (movie, image) in
                        self.delegate?.onNeedToDetailViewController(movie: movie, image: image)
                    }
                    return cell
                }
                
            }
        }
        
        return UITableViewCell()
    

    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        items[safe: section]?.headerTitle
    }
    

}



protocol HomeViewModelItem {
    var count: Int {get}
    var items: [Any] {get set}
    var headerTitle: String {get}
    var type: HomeViewModelType { get }
}

enum HomeViewModelType: String{
    case banner = ""
    case popular = "Popular Movies"
    case comingSoon = "Coming Soon"
}

struct HomeBannerViewModel: HomeViewModelItem  {
    
    var type: HomeViewModelType{
        .banner
    }
    
    var headerTitle: String{
        type.rawValue
    }
    

    var count: Int{
        return items.count
    }
    
    var items: [Any]
    
}

struct HomePopularMoviesViewModel: HomeViewModelItem  {
    
    var type: HomeViewModelType{
        .popular
    }
    
    var headerTitle: String{
          type.rawValue
      }
    

    var count: Int{
        return items.count
    }
    
    var items: [Any]
    
}

struct HomeComingSoonMoviesViewModel: HomeViewModelItem  {
    
    var type: HomeViewModelType{
        .comingSoon
    }
    
    var headerTitle: String{
          type.rawValue
      }
    

    var count: Int{
        return items.count
    }
    
    var items: [Any]
    
}



