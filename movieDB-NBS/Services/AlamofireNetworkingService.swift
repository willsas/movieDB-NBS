//
//  AlamofireNetworkingService.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireNetworkingService: NetworkingService {
    func perform<T>(resource: Resource<T>, completion: @escaping (Swift.Result<T, NetworkingError>) -> Void) where T : Decodable, T : Encodable {
        
        
        // load from cache if any
        if let dict = UserDefaults.standard.object(forKey: "DataCache") as? [String: String]{
            if let path = dict[resource.cacheUniqueID ?? resource.url.absoluteString]{
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    do{
                        let result = try JSONDecoder().decode(T.self, from: data)
                        print("This perform network \(resource.url) use real CACHE!")
                        completion(.success(result))
                        return
                    }catch(_){
                        print("No data from cache")
                    }
                    
                }
            }
        }
        
        
        //perform
        Alamofire.request(resource.url, method: Alamofire.HTTPMethod(rawValue: resource.httpMethod.rawValue)!, parameters: resource.params)
            .validate()
            .responseData(completionHandler: { (respone) in
                
                switch respone.result{
                case .success(let data):
                    
                    do{
                        let result = try JSONDecoder().decode(T.self, from: data)
                        CacheService.storeData(uniqueID: resource.cacheUniqueID ?? resource.url.absoluteString, data: data)
                        print("This perform network \(resource.url) use REAL CONNECTION!")
                        completion(.success(result))
                        
                    }catch(let err){
                        completion(.failure(NetworkingError.err(err)))
                        
                    }
                    
                    
                case .failure(let err):
                    completion(.failure(NetworkingError.err(err)))
                }
                
            })
        
    }
    
    
}

    

