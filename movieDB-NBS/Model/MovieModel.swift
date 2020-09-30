//
//  MovieModel.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation

struct MovieModel: Codable{
    
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage, originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}



extension MovieModel{
    
    /// Reource to get Banner
    /// - Returns: Resource base model of [Movie Model]
    static func bannerReource() -> Resource<BaseModel<[MovieModel]>>{
        let baseApiURL = URL(string: Environment.configuration(.baseURLAPI))!
        let url = baseApiURL.appendingPathComponent("/discover/movie")
        let params = [
            "api_key" : Environment.configuration(.apiKey),
            "page": "1"
        ]
        return Resource<BaseModel<[MovieModel]>>(url: url, httpMethod: .get, params: params, headers: nil, cacheUniqueID: url.absoluteString + params.flatMap({$0 + $1}) + "banner")
    }
    
    /// Resource to get popular movie
    /// - Returns: Resource BaseModel [MovieModel]
    static func popularMoviesReource() -> Resource<BaseModel<[MovieModel]>>{
        let baseApiURL = URL(string: Environment.configuration(.baseURLAPI))!
        let url = baseApiURL.appendingPathComponent("/discover/movie")
        let params = [
            "api_key" : Environment.configuration(.apiKey),
            "sort_by" : "popularity.desc",
            "page": "1"
        ]
        return Resource<BaseModel<[MovieModel]>>(url: url, httpMethod: .get, params: params, headers: nil, cacheUniqueID: url.absoluteString + params.flatMap({$0 + $1}) + "popularityMovies")
    }
    /// Resource to get cooming soon movie
    /// - Returns: Resource BaseModel [MovieModel]
    static func comingSoonResource(year: String = "2021") -> Resource<BaseModel<[MovieModel]>>{
        let baseApiURL = URL(string: Environment.configuration(.baseURLAPI))!
        let url = baseApiURL.appendingPathComponent("/discover/movie")
        let params = [
            "api_key" : Environment.configuration(.apiKey),
            "sort_by" : "popularity.desc",
            "year": year,
            "page": "1"
        ]
        return Resource<BaseModel<[MovieModel]>>(url: url, httpMethod: .get, params: params, headers: nil, cacheUniqueID: url.absoluteString + params.flatMap({$0 + $1}) + "comingSoonMoviews")
    }
}
