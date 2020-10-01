//
//  FavouriteViewController.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    typealias Factory = CoordinatorFactory & PersistenceServiceFactory
    private let factory: Factory
    private let vm: FavouriteViewModel
    private let disposeBag = DisposeBag()
    private let cellID = String(describing: FavouriteTableViewCell.self)
    private lazy var searchController = UISearchController()
    private lazy var coordinator = factory.makeFavouriteCoordinator(vc: self)
    
    
    init(factory: Factory) {
        self.factory = factory
        self.vm = FavouriteViewModel(factory: factory)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupTableView()
        setupSearchBar()
        vm.populateMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.populateMovie()
    }
    
    
    /// Setup tableVeiw
    private func setupTableView(){
        tableViewOutlet.register(FavouriteTableViewCell.self)
    }
    
    
    /// Set search bar and listen to delegate
    private func setupSearchBar(){
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
    
    
    /// Setup binding tableview \
    /// Listen to datasource and tableview ItemSelected
    private func setupBinding(){
        
        // table datasource
        vm.itemReadyToBind.bind(to: tableViewOutlet.rx.items(cellIdentifier: cellID, cellType: FavouriteTableViewCell.self)){ row, item, cell in
            cell.item = item
            cell.favouriteButtonTapped = { [unowned self] in
                self.requsetToRemoveFavourite(movie: item)
            }
        }.disposed(by: disposeBag)
        
        // table action
        tableViewOutlet.rx.itemSelected.map{$0.item}
            .subscribe(onNext: { [unowned self] row in
                
                guard let movie = self.vm.itemsAt(index: row),
                    let cell = self.tableViewOutlet.cellForRow(at: IndexPath(row: row, section: 0)) as? FavouriteTableViewCell,
                    let image = cell.imageOutlet.image else {return}
                
                self.coordinator.pushToDetailViewController(movie: movie, image: image)
                
            }).disposed(by: disposeBag)
    }
    
    
    /// Delete given MovieModel and refresh movie
    /// - Parameter movie: given MovieModel
    private func requsetToRemoveFavourite(movie: MovieModel){
        UIAlertController.basicAlertWithCompletion(title: "Are you sure you want to remove?", message: "This will remove \"\(movie.title)\" from your favourite", buttonTitle: "Remove", vc: self) { [unowned self] (_) in
            self.vm.deleteFavouriete(movie: movie)
            self.vm.populateMovie()
        }
    }
    
}


extension FavouriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.query(string: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        vm.query(string: "")
    }
    
}
