//
//  DetailViewController.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var subtitleLabelOutlet: UILabel!
    @IBOutlet weak var favouriteButtonOutlet: UIButton!
    @IBOutlet weak var watchNowButtonOutlet: UIButton!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var isFavouriteCheckMark: UIButton!
    
    
    typealias Factory = PersistenceServiceFactory
    private let factory: Factory
    private let vm: DetailViewModel
    private let disposeBag = DisposeBag()
    
    
    init(factory: Factory, movie: MovieModel, image: UIImage) {
        self.factory = factory
        self.vm = DetailViewModel(factory: factory, movie: movie, image: image)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        watchNowButtonOutlet.layer.cornerRadius = 4
    }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        vm.toggleIsFav()
    }
    
    
    /// Setup outlet binding
    private func setupBinding(){
        vm.titleBinder.bind(to: titleLabelOutlet.rx.text).disposed(by: disposeBag)
        vm.subtitleBinder.bind(to: subtitleLabelOutlet.rx.text).disposed(by: disposeBag)
        vm.imageBinder.bind(to: imageOutlet.rx.image).disposed(by: disposeBag)
        vm.isFavouriteBinder.map{!$0}.bind(to: isFavouriteCheckMark.rx.isHidden).disposed(by: disposeBag)
    }
    
    
    
}
