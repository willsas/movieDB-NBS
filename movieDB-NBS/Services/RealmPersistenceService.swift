//
//  RealmPersistenceService.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

//import Foundation
//import RealmSwift
//
//struct RealmPersistenceService: PersistenceService {
//    
//    let realm = try! Realm()
//    
//    func saveData<T>(_ value: T?, forKey defaultName: PersistenceServiceKey) where T : Decodable, T : Encodable {
//        do{
//            let data = try JSONEncoder().encode(value)
//            try realm.write{
//                realm.add(Object(value: data))
//            }
//        }catch(let err){
//            print("failed to save data, \(err.localizedDescription)")
//        }
//        
//    }
//    
//    func retriveData<T>(_ type: T.Type, forKey defaultName: PersistenceServiceKey) -> T? where T : Decodable {
//        let data = realm.objects(type)
//        let puppies = realm.objects(Object(value: type.self).type)
//        
//    }
//    
//    func delete(key: PersistenceServiceKey) {
//        
//    }
//    
//    
//}
