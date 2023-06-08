//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 08.06.2023.
//

import Foundation

/// A model to parse Top250Movies IMDb API as top level [array of movies]
struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

/// A model to parse Top250Movies IMDb API as json model with data about uniq movie (only neccessary fields)
struct MostPopularMovie: Codable {
    let title: String
    let rating: String
    let imageURL: URL
    
    // enum requered for renaiming fields
    private enum CodingKeys: String, CodingKeys {
        case title = "fullTitle"
        case reting = "imDbRating"
        case imageURL = "image"
    }
}
