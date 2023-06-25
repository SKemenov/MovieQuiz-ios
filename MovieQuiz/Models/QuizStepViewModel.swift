//
//  QuizStepViewModel.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation

// import into the viewModel only UIImage, not all UIKit library
import UIKit.UIImage

// MARK: - Structs
struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
}
