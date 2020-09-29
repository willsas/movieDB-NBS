//
//  PersistenceService.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation


/// Key for an object that conform Persistable Protocol
enum PersistenceServiceKey: String{
    
   // Bool.self
    case login
    
    // [Int].self
    case favouriteMovieIDs
    
    // [MoviewModel].self
    case favouriteMovie
}


protocol PersistenceService {
    
    /// Saving data
    /// - Parameters:
    ///   - value: the value want to save, **the type of the value  should match the choosen "forKey" parameter (see  each key descriptions)**
    ///   - defaultName: enum PersistenceServiceKey
    func saveData<T: Codable>(_ value: T?, forKey defaultName: PersistenceServiceKey)
    
    
    /// Return data generic
    /// - Parameters:
    ///   - type: the object type you want to retrive, **the object type  should match the choosen "forKey" parameter (see  each key descriptions)**
    ///   - defaultName: enum PersistenceServiceKey
    /// - Returns: a value from the given key, it's   generic type from `type` params
    func retriveData<T>(_ type: T.Type, forKey defaultName: PersistenceServiceKey) -> T? where T : Decodable
    
    
    /// Deleting from the saved value
    /// - Parameter key: enum PersistenceServiceKey
    func delete(key: PersistenceServiceKey)
    
    
}
