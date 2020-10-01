//
//  PopularCollectionViewCell.swift
//  movieDB-NBS
//
//  Created by Willa on 30/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import SDWebImage

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var subtitleOutlet: UILabel!
    
    private var baseURLImage = URL(string: Environment.configuration(.baseURLImage))!
    
    var item: MovieModel?{
        didSet{
            guard let imagePath = item?.posterPath else {return}
            
            imageOutlet.sd_setImage(with: baseURLImage.appendingPathComponent(imagePath))
            
            titleOutlet.text = item?.title
            subtitleOutlet.text = item?.overview
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    

}
