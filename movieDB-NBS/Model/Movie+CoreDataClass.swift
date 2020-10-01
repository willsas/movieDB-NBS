//
//  Movie+CoreDataClass.swift
//  movieDB-NBS
//
//  Created by Willa on 01/10/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    
    
    func asMovieModel() -> MovieModel{
        return MovieModel(id: Int(id), posterPath: posterPath ?? "", title: title ?? "", overview: overview ?? "")
    }

}
