//
//  NetworkManager.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import Foundation

class NetworkManager {
    class func getDataFromApi<T: Decodable>(fromUrl url:String, completion:@escaping (T?)->Void) {
        guard let urlObject = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlObject) {(data, response, error) in
            do {
                guard let data = data else{
                    completion(nil)
                    return
                }
                let jsonArray = try JSONDecoder().decode(T.self, from: data)
                completion(jsonArray);
                
            } catch {
                debugPrint("Error in Fetching Data: \(error)")
            }
            debugPrint("Network Request Is Completed")
        }.resume()
    }
}
