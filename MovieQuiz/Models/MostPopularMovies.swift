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
//    let title: String
//    let rating: String
//    let imageURL: URL
 
    /// enum requered for renaiming Top250Movies IMDb API fields
    // this enum doesn't work
    //private enum CodingKeys: String, CodingKey {
    //    case title = "fullTitle"
    //    case rating = "imDbRating"
    //    case imageURL = "image"
    //}
    
    // 2nd way without renaiming fields
    let fullTitle: String
    let imDbRating: String
    let image: URL

    var resizedImageURL: URL {
        // создаем строку из адреса
        let urlString = image.absoluteString
        //  обрезаем лишнюю часть и добавляем модификатор желаемого качества
        let imageUrlString = urlString.components(separatedBy: "._")[0] + "._V0_UX600_.jpg"
        
        // пытаемся создать новый адрес, если не получается возвращаем старый
        guard let newURL = URL(string: imageUrlString) else {
            return image
        }
        return newURL
    }
    
    enum CodingKeys: CodingKey {
        case fullTitle
        case imDbRating
        case image
    }
}
