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
///        Struct to hold an information about the question
struct QuizQuestion {
    // picture name == movie name
    let name: String
    // question
    let text: String
    // rightAnswer
    let correctAnswer: Bool
}
