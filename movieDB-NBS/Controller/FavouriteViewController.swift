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
    private lazy var searchConroller = UISearchController()
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
    
    private func setupTableView(){
        tableViewOutlet.register(FavouriteTableViewCell.self)
    }
    
    
    private func setupSearchBar(){
        navigationController?.navigationItem.searchController = searchConroller
        searchConroller.searchBar.delegate = self
    }
    
    
    
    
    
    private func setupBinding(){
        vm.itemReadyToBind.bind(to: tableViewOutlet.rx.items(cellIdentifier: cellID, cellType: FavouriteTableViewCell.self)){ row, item, cell in
            cell.item = item
        }.disposed(by: disposeBag)
        
        tableViewOutlet.rx.itemSelected.map{$0.item}
            .subscribe(onNext: { [unowned self] row in
                
                
                guard let movie = self.vm.itemsAt(index: row),
                    let cell = self.tableViewOutlet.cellForRow(at: IndexPath(row: row, section: 0)) as? FavouriteTableViewCell,
                    let image = cell.imageOutlet.image else {return}
                
                self.coordinator.pushToDetailViewController(movie: movie, image: image)
                
                
                
            }).disposed(by: disposeBag)
        
    }
    
    
}

extension FavouriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.query(string: searchText)
    }
    
}
