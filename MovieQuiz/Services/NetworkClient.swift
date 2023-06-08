//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 06.06.2023.
//

import Foundation


/// `NetworkClient` is loading data from URL
struct NetworkClient {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        print("request\n\(request)\n\n")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // error return check
            if let error = error {
                handler(.failure(error))
                return
            }
            
            // unsuccess response code return check
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
//               response.statusCode != 200...300 {
                print("response.statusCode \(response.statusCode)")
                handler(.failure(NetworkError.codeError))
                return
            }
            
            //happy path
            guard let data = data else { return }
            print("data for happy path \n\(data)\n\n")
            handler(.success(data))
        }
        
        task.resume()
    }
}
