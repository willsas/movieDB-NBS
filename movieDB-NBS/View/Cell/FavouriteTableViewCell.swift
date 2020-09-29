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
    
    private var baseURL = URL(string: Environment.configuration(.baseURLImage))!
    
    var item: MovieModel?{
        didSet{
            guard let posterPath = item?.posterPath else {return}
            imageOutlet.sd_setImage(with: baseURL.appendingPathComponent(posterPath))
            titleOutlet.text = item?.title
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
