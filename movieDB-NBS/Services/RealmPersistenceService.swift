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
//        guard value.self is Object.Type else {fatalError("The object you trying to save does not conform to Object protocol in RealmSwift")}
//        do{
//            try realm.write{
//                realm.add(value as! Object)
//            }
//        }catch(let err){
//            print("failed to save data, \(err.localizedDescription)")
//        }
//        
//    }
//    
//    func retriveData<T>(_ type: T.Type, forKey defaultName: PersistenceServiceKey) -> T? where T : Decodable, T: Object {
//        //        guard type == Object.self else {fatalError("The object you trying to save does not conform to Object protocol in RealmSwift")}
//        return realm.objects(type)[0]
//        
//    }
//    
//    func delete(key: PersistenceServiceKey) {
//        
//    }
//    
//    
//}
