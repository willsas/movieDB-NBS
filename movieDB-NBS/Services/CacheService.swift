//
//  CacheNetworkingService.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import UIKit

class CacheService {
    
    /// Store Image To Cache service
    /// - Parameters:
    ///   - uniqueID: unique id
    ///   - img: actual uiimage
    static func storeImage(uniqueID: String, img: UIImage){
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String: String]
        if dict == nil{
            dict = [String: String]()
        }
        dict![uniqueID] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
    
    /// Store data to cache
    /// - Parameters:
    ///   - uniqueID: unique id
    ///   - data: Data type
    static func storeData(uniqueID: String, data: Data){
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        try? data.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "DataCache") as? [String: String]
        if dict == nil{
            dict = [String: String]()
        }
        dict![uniqueID] = path
        UserDefaults.standard.set(dict, forKey: "DataCache")
    }
}
