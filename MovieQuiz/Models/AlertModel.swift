//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

// MARK: - Structs
struct AlertModel {
    let title: String
    let text: String
    let buttonText: String
    let completion: () -> Void
}

