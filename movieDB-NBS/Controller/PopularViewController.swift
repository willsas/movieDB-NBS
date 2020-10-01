//
//  PopularViewController.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    typealias Factory = MovieServiceFactory & CoordinatorFactory
    private let factory: Factory
    private let vm: PopularViewModel
    
    private let padding = 5
    private lazy var coordinator = factory.makePopularCoordinator(vc: self)
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    
    init(factory: Factory) {
        self.factory = factory
        self.vm = PopularViewModel(factory: factory)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        setupCollectionView()
        setupSearchbar()
        vm.requestPopularMovie()
    }
    
    
    
    /// Setup CollectionView
    private func setupCollectionView(){
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = vm
        collectionViewOutlet.register(PopularCollectionViewCell.self)
    }
    
    /// Set search bar in navigation controller
    private func setupSearchbar(){
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
    
    
}





extension PopularViewController: PopularViewModelDelegate{
    func onPushToDetail(movie: MovieModel, image: UIImage) {
        coordinator.pushToDetailViewController(movie: movie, image: image)
    }
    
    func onError(title: String, subtitle: String) {
        UIAlertController.basicAlert(title: title, message: subtitle, vc: self)
    }
    
    func onReloadData() {
        collectionViewOutlet.reloadData()
    }
    
    
}

extension PopularViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.queryWith(string: searchText)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        vm.queryWith(string: "")
    }
}

extension PopularViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - CGFloat(padding) * 2) / CGFloat(2)
        let height = width * (16 / 9) + 80
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movie = vm.movieAt(indexPath: indexPath),
            let cell = collectionView.cellForItem(at: indexPath) as? PopularCollectionViewCell,
            let image = cell.imageOutlet.image else {return}
        
        coordinator.pushToDetailViewController(movie: movie, image: image)
        
    }
    
}
