//
//  CoreDataPersistenceService.swift
//  movieDB-NBS
//
//  Created by Willa on 01/10/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataPersistenceService: PersistenceService {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveData<T>(_ value: T?, forKey defaultName: PersistenceServiceKey) where T : Decodable, T : Encodable {
        
        
        switch defaultName {
            
        case .coreDataMovie:
            
            guard let item = value as? MovieModel else {return}
            let newMovie = Movie(context: context)
            newMovie.id = Int64(item.id)
            newMovie.posterPath = item.posterPath
            newMovie.overview = item.overview
            newMovie.title = item.title
            
            
            do{
                try context.save()
            }catch(let err){
                fatalError("failed to save to core data \(err.localizedDescription)")
            }
            
            
        default:
            fatalError("failed to save to core data, error : The given PersistenceServiceKey is not define as core data")
            break
        }
        
    }
    
    func retriveData<T>(_ type: T.Type, forKey defaultName: PersistenceServiceKey) -> T? where T : Decodable {
        return nil
        
    }
    
    
    
    
    func delete(key: PersistenceServiceKey) {
        
    }
    
    
    func fetchCoreData<T>(key: PersistenceServiceKey, as type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        
        switch key {
        case .coreDataMovie:
            
            
            do{
                let items = try context.fetch(Movie.fetchRequest()) as? [Movie]
                guard let saveItems = items else {return}
                let result = saveItems.map {$0.asMovieModel()}
                completion(.success(result as! [T]))
                
            }catch(let err){
                completion(.failure(err))
            }
            
            
            
            
        default:
            fatalError("failed to save to core data, error : The given PersistenceServiceKey is not define as core data")
//            completion(.failure(NetworkingError.other("Failed to save")))
        }
    }
    
    
    
}
