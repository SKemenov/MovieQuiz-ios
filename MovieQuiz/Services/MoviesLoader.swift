//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 08.06.2023.
//

import Foundation

// MARK: - Protocol

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

// MARK: - Structure

struct MovieLoader: MoviesLoading {
    private let networkClient: NetworkRouting
	// use most popular or top250 movie's IMDb API
	private let imdbUrl = "https://imdb-api.com/en/API/"
	private let imdbApi = Bool.random() ? "MostPopularMovies/" : "Top250Movies/"
    private let imdbToken = "k_gbe4ep0b"
    
    init(networkClient: NetworkRouting = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    private var mostPopularMoviesUrl: URL {
        guard let url = URL(string: imdbUrl + imdbApi + imdbToken) else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }

    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
                case .success(let data):
                    do {
                        let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                        handler(.success(mostPopularMovies))
                    }
                    catch {
                        handler(.failure(error))
                    }
                case .failure(let error):
                    handler(.failure(error))
            }
        }
    }
}

struct MovieLoaderFromKinopiosk: MoviesLoading {
	private let networkClient: NetworkRouting
	private let kinopoiskUrl = "https://api.kinopoisk.dev/v1.3/movie?page=1&limit=10&typeNumber=1&top250=%21null"
//	private let kinopoiskToken = "3FWVXVZ-KJGMHZS-P95YZS7-E2DKHQJ"

	init(networkClient: NetworkRouting = NetworkClient()) {
		self.networkClient = networkClient
	}

	private var mostPopularMoviesUrl: URL {
		guard let url = URL(string: kinopoiskUrl) else {
			preconditionFailure("Unable to construct mostPopularMoviesUrl")
		}
		return url
	}

	func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
		networkClient.fetch(url: mostPopularMoviesUrl) { result in
			switch result {
				case .success(let data):
					do {
						let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
						handler(.success(mostPopularMovies))
					}
					catch {
						handler(.failure(error))
					}
				case .failure(let error):
					handler(.failure(error))
			}
		}
	}


}
