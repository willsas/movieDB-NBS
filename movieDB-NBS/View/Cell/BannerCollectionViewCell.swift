//
//  BannerCollectionViewCell.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    private let baseURL = URL(string: Environment.configuration(.baseURLImage))!
    
    var posterPath: String?{
        didSet{
            guard let path = posterPath else {return}
            imageOutlet.sd_setImage(with: baseURL.appendingPathComponent(path))
            print(baseURL.appendingPathComponent(path))
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
