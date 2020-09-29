//
//  HomeViewController.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    typealias Factory = MovieServiceFactory & CoordinatorFactory
    private let factory: Factory
    private let vm: HomeViewModel
    
    private lazy var coordinator = factory.makeHomeCoordinator(vc: self)
    
    init(factory: Factory) {
        self.factory = factory
        self.vm = HomeViewModel(factory: factory)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        setupTableView()
        vm.requestToFetchBanner()
        vm.reqeustToFetchPopularMovies()
        vm.requestToFetchCommingSoonMovies()
    }
    
    
    private func setupTableView(){
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = vm
        tableViewOutlet.register(BannerTableViewCell.self)
        tableViewOutlet.register(HomeMovieTableViewCell.self)
    }
}

extension HomeViewController: HomeViewModelDelegate{
    func onNeedToDetailViewController(movie: MovieModel, image: UIImage) {
        coordinator.pushToDetailViewController(movie: movie, image: image)
    }
    
    func onReloadData() {
        tableViewOutlet.reloadData()
    }
    
    func onError(title: String, subtitle: String) {
        UIAlertController.basicAlert(title: title, message: subtitle, vc: self)
    }
    
    
}



extension HomeViewController: UITableViewDelegate{
    
}
