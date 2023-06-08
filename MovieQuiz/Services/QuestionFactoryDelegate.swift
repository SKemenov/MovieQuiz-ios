//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 16.05.2023.
//

import Foundation

//  MARK: - Protocol

/// This's a delegate to control receiving questions from our Factory.
protocol QuestionFactoryDelegate: AnyObject {
    
    /// Request a delegate method for updating UI after loading the question.
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // happy path response
    func didFailToLoadData(with error: Error) // unhappy path response
}
