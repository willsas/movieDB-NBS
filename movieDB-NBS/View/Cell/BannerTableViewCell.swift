//
//  BannerTableViewCell.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    
    private var cellID = String(describing: BannerCollectionViewCell.self)
    
    
    var vm: HomeBannerViewModel?{
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

    
    }
    
    
    private func setupCollectionView(){
        collectionViewOutlet.register(BannerCollectionViewCell.self)
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.delegate = self
        collectionViewOutlet.isPagingEnabled = true
    }
    
    
    
}




extension BannerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = vm else {return 0}
        return vm.count > 10 ? 10 : vm.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? BannerCollectionViewCell,
            let selectedItem = vm?.items[safe: indexPath.row] as? String{
            cell.posterPath = selectedItem
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    

    
}
