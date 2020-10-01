//
//  FavouriteTableViewCell.swift
//  movieDB-NBS
//
//  Created by Willa on 30/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import SDWebImage

class FavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var contentViewOutlet: UIView!
    
    private var baseURL = URL(string: Environment.configuration(.baseURLImage))!
    
    var favouriteButtonTapped: () -> Void = {}
    
    var item: MovieModel?{
        didSet{
            guard let posterPath = item?.posterPath else {return}
            imageOutlet.sd_setImage(with: baseURL.appendingPathComponent(posterPath))
            titleOutlet.text = item?.title
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentViewOutlet.layer.cornerRadius = 4
        imageOutlet.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        favouriteButtonTapped()
    }
    
}
