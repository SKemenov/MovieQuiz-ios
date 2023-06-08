//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 08.06.2023.
//

import Foundation


protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

/// A service to connecting to IMDb API and loading Top250Movies data into `MostPopularMovies`
struct MovieLoader: MoviesLoading {
    private let networkClient = NetworkClient()
    private let imdbUrl = "https://imdb-api.com/en/API/Top250Movies/"
    private let imdbToken = "k_gbe4ep0b"
    
    private var mostPopularMoviesUrl: URL {
//        guard let url = URL(string: imdbUrl + imdbToken) else {
            guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_gbe4ep0b") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        print("url \n \(url)\n\n")
        return url
    }
    

    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
                case .success(let data):
                    do {
                        let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                        print("mostPopularMovies\n\(mostPopularMovies)\n\n")
                        handler(.success(mostPopularMovies))
                    }
                    catch {
                        print("catch error")
                        handler(.failure(error))
                    }
                case .failure(let error):
                    print("failure")
                    handler(.failure(error))
            }
        }
    }
    
    
}
