//
//  UICollectionView+Extension.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

extension UICollectionView{
    
    /// Register custom collection cell to it's collection view
    /// - Parameter type: CollectionViewCell type
    public func register(_ type:UICollectionViewCell.Type){
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    
}
