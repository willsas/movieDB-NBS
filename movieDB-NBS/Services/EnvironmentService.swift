//
//  EnvironmentService.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//


import Foundation


public enum Plist{
    
    /// Moview DB API key
    case apiKey
    
    ///https://api.themoviedb.org/3
    case baseURLAPI
    
    ///https://image.tmdb.org/t/p/original
    case baseURLImage
    
    func value() -> String{
        switch self {
        case .apiKey:
            return "API_KEY"
        case .baseURLAPI:
            return "BASE_URL_API"
        case .baseURLImage:
            return "BASE_URL_IMAGE"
        }
    }
}

public struct Environment{
    static func configuration(_ key: Plist) -> String{
        if let infoDict = Bundle.main.infoDictionary {
            return infoDict[key.value()] as? String ?? ""
        }else{
            fatalError("\(self) bundle plist with value \(key.value()) is not found!")
        }
    }
}
