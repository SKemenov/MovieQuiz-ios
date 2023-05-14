//
//  QuizResultsViewModel.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation
// MARK: - Structs
//
//
/// Struct to colleect information for the 'resultShowed' state of the state machine
struct QuizResultsViewModel {
    // alert's title
    let title: String
    // alert's message
    let text: String
    // alert button's label
    let buttonText: String
}
