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
/// A structure to hold an information for the `questionShowed` state of the state machine.
///
/// The `QuizStepViewModel` structure has the following properties:
///
/// - term **image: UIImage**: Used to represent a picture for the current movie.
/// *****
/// - term **question: String**: Used to represent a question about the current movie.
/// *****
/// - term **questionNumber: String**: Used to represent the question's number of all (ex. "2/10").
///
/// - Important: The `QuizStepViewModel` structure has no methods.
/// - Requires: `import UIKit` - to work with UIImage.
struct QuizStepViewModel {
    //  MARK: - Properties
    //
    //
    let image: UIImage
    let question: String
    let questionNumber: String
    
}
