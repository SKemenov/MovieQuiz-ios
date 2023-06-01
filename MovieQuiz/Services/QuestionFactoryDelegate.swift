//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 16.05.2023.
//

import Foundation

/// This's a delegate to control receiving questions from our Factory.
///
/// To be compatible should implement `didReceiveNextQuestion(question:)` method.
protocol QuestionFactoryDelegate: AnyObject {
    
    /// Request a callback method for updating UI after loading the question.
    /// - Parameter question: a question or `nil`
    func didReceiveNextQuestion(question: QuizQuestion?)
}
