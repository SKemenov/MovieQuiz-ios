//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

// MARK: - Structs
//
//
/// A structure to collect information for the 'AlertPresenter' and show the final alert with game's score.
/// The `AlertModel` structure has the following properties:
///
/// - term **title: String**: Used to represent the alert's title.
/// *****
/// - term **text: String**: Used to represent the alert's message.
/// *****
/// - term **buttonText: String**: Used to represent the alert button's label.
/// *****
/// - term **completion: Closure**: Used to represent the alert button's actions.
///
struct AlertModel {
    let title: String
    let text: String
    let buttonText: String
    let completion: () -> Void
  
}

