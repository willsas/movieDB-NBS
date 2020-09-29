//
//  HomePopularTableViewCell.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

class HomeMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var headerTitleOutlet: UILabel!
    
    private var cellID = String(describing: HomeMovieCollectionViewCell.self)
    
    
    var popularItems: HomePopularMoviesViewModel?{
        didSet{
            guard let movies = popularItems?.items as? [MovieModel] else {return}
            self.movies = movies
            headerTitleOutlet.text = popularItems?.headerTitle
        }
    }
    
    var comingSoonItems: HomeComingSoonMoviesViewModel?{
        didSet{
            guard let movies = comingSoonItems?.items as? [MovieModel] else {return}
            self.movies = movies
            headerTitleOutlet.text = comingSoonItems?.headerTitle
        }
    }
    
    var onSelectedMovie: (MovieModel, UIImage) -> Void = {_, _ in}
    
    
    private var movies = [MovieModel](){
        didSet{
            collectionViewOutlet.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func setupCollectionView(){
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.delegate = self
        collectionViewOutlet.register(HomeMovieCollectionViewCell.self)
    }
    
}


extension HomeMovieTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count > 10 ? 10 : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? HomeMovieCollectionViewCell,
            let item = movies[safe: indexPath.row]{
            cell.items = item
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 100, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = movies[safe: indexPath.item],
            let cell = collectionView.cellForItem(at: indexPath) as? HomeMovieCollectionViewCell,
            let image = cell.imageOutlet.image else {return}
        onSelectedMovie(movie, image)
        
    }
    
    
}
