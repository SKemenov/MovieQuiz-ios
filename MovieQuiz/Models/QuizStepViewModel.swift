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

/// A structure to hold an information for the `questionShowed` state of the state machine.

struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
    
}
