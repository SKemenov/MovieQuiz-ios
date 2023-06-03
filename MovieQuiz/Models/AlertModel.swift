//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

// MARK: - Structs

/// A structure to collect information for the 'AlertPresenter' and show the final alert with game's score.

struct AlertModel {
    let title: String
    let text: String
    let buttonText: String
    let completion: () -> Void
  
}

