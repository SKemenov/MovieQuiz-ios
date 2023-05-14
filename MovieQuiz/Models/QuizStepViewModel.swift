//
//  QuizStepViewModel.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation
import UIKit

// MARK: - Structs
//
//
///    Struct to hold an information for the 'questionShowed' state of the state machine
struct QuizStepViewModel {
    // picture
    let image: UIImage
    // question
    let question: String
    // question number of all (ex. "2/10")
    let questionNumber: String
}
