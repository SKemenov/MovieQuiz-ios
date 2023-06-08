//
//  MostPopularMovies.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 08.06.2023.
//

import Foundation


/// enum requered for renaiming Top250Movies IMDb API fields
//private enum CodingKeys: String, CodingKey {
//    case title = "fullTitle"
//    case rating = "imDbRating"
//    case imageURL = "image"
//}

/// A model to parse Top250Movies IMDb API as top level [array of movies]
struct MostPopularMovies: Codable {
    let errorMessage: String
    let items: [MostPopularMovie]
}

/// A model to parse Top250Movies IMDb API as json model with data about uniq movie (only neccessary fields)
struct MostPopularMovie: Codable {
    let fullTitle: String
    let imDbRating: String
    let image: URL
    
    enum CodingKeys: CodingKey {
        case fullTitle
        case imDbRating
        case image
    }
}
