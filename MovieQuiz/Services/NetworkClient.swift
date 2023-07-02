//
//  NetworkClient.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 06.06.2023.
//

import Foundation

// MARK: - Protocol

protocol NetworkRouting {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
}

// MARK: - Structure

struct NetworkClient: NetworkRouting {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // error return check
            if let error = error {
                handler(.failure(error))
                return
            }
            
            // unsuccess response code return check
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            
            //happy path
            guard let data = data else { return }
            handler(.success(data))
        }
        
        task.resume()
    }
}

