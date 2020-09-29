//
//  HomePopularCollectionViewCell.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import SDWebImage

class HomePopularCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var subtitleOutlet: UILabel!
    
    var baseURL = URL(string: Environment.configuration(.baseURLImage))!
    
    
    var items: MovieModel?{
        didSet{
            
            titleOutlet.text = items?.title
            subtitleOutlet.text = items?.overview
            imageOutlet.sd_setImage(with: baseURL.appendingPathComponent(items?.posterPath ?? ""))
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageOutlet.layer.cornerRadius = 4
    }

}
