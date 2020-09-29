//
//  URLSessionNetworkingService.swift
//  movieDB-NBS
//
//  Created by Willa on 29/09/20.
//  Copyright © 2020 WillaSaskara. All rights reserved.
//

import Foundation


struct URLSessionNetworkingService: NetworkingService {
   
    func perform<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkingError>) -> Void) where T : Decodable, T : Encodable {
        
//
//        // construct and modify url components
//        var urlComponents = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
//        urlComponents?.queryItems = resource.params.map {URLQueryItem(name: $0, value: $1)}
//
//        //         construct url request
//        guard let url  = urlComponents?.url else {return}
//        var urlRequest = URLRequest(url: url)
//
//
//        if resource.httpMethod == .post || resource.httpMethod == .put{
//
//            urlRequest = URLRequest(multipartFormData: { (formData) in
//
//                if let data = resource.data{
//                    formData.append(file: data, name: "avatar", fileName: "avatar.jpg", mimeType: "image/jpeg")
//                }
//
//                _ = finalParams.map {formData.append(value: $1, name: $0)}
//
//            }, url: resource.url
//            )
//
//        }
//
//        // modify url request
//        _ = finalHeader.map {urlRequest.addValue($1, forHTTPHeaderField: $0)}
//        urlRequest.httpMethod = resource.httpMethod.rawValue
//
//
//
//
//        // Network call
//        URLSessionConfiguration.default.timeoutIntervalForRequest = 20
//        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, err) in
//
//            DispatchQueue.main.async {
//                if let err = err{
//                    completion(.failure(NetworkingError.err(err)))
//                    return
//                }
//
//                if let response = response as? HTTPURLResponse {
//
//                    switch response.statusCode {
//                    case (200...299), 422, 403:
//                        do{
//                            guard let data = data else {throw NetworkingError.other("No Data")}
//                            completion(.success(try JSONDecoder().decode(T.self, from: data)))
//                        }catch (let err){
//                            completion(.failure(NetworkingError.err(err)))
//                        }
//                    case 401:
//                        completion(.failure(NetworkingError.other("Error: Unauthorized, (\(response.statusCode))")))
//                    case 404:
//                        completion(.failure(NetworkingError.other("Error: Not found, (\(response.statusCode))")))
//                    case 500:
//                        completion(.failure(NetworkingError.other("Error: Server error, (\(response.statusCode))")))
//                    default:
//                        completion(.failure(NetworkingError.other("Error: Status code \(response.statusCode)")))
//                    }
//
//                }
//            }
//
//        }).resume()
//        print("URL request : /nURL:\(urlRequest)")
//        print("PERFORM NETWORK WITH RESOURCE: \(resource), with final header: \(resource.headers)")
//
//
//
    }
//
    
}

