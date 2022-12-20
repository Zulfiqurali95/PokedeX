//
//  AppDelegate.swift
//  PokedeZ
//
//  Created by Zulfiqur Ali on 12/10/22.
//

import Foundation


extension URLSession{
    enum RequestErrors:Error{
        case badURL
        case badData
    }
}

extension URLSession{
    
  
    func getRequest<T:Codable>(url: URL?, decoding: T.Type, completion: @escaping (Result<T, Error>)->()){
        
        guard let url = url else {
            completion(.failure(RequestErrors.badURL))
            return
        }
        
        let task = self.dataTask(with: url){ data, _, error in
            
            guard data != nil else{
                completion(.failure(RequestErrors.badData))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonResult = try decoder.decode(decoding, from: data!)
                completion(.success(jsonResult))
                //print(jsonResult)
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
}
