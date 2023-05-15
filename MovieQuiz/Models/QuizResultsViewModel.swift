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
/// A structure to collect information for the 'resultShowed' state of the state machine.
///
/// The `QuizResultsViewModel` structure has the following properties:
///
/// - term **title: String**: Used to represent the alert's title.
/// *****
/// - term **text: String**: Used to represent the alert's message.
/// *****
/// - term **buttonText: String**: Used to represent the alert button's label.
///
/// - Important: The `QuizResultsViewModel` structure has no methods.
struct QuizResultsViewModel {
    //  MARK: - Properties
    //
    //
    let title: String
    let text: String
    let buttonText: String
    
}
