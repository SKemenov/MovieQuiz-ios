//
//  MovieLoaderFromKinopiosk.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 02.07.2023.
//

import Foundation

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
