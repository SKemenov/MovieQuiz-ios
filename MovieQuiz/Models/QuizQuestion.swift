//
//  QuizQuestion.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation

// MARK: - Structs
//
//
/// A structure to hold an information about the question.
///
/// The `QuizQuestion` structure has the following properties:
///
/// - term **name: String**: Used to represent a movie name (and using as a picture name too).
/// *****
/// - term **text: String**: Used to represent a question about the current movie.
/// *****
/// - term **correctAnswer: Bool**: Used to represent the correct asnwer for the question is the `true` or `false`.
///
/// - Important: The `QuizQuestion` structure has no methods.
struct QuizQuestion {
    //  MARK: - Properties
    //
    //
    let name: String
    let text: String
    let correctAnswer: Bool
    
}
