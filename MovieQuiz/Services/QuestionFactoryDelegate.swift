//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 16.05.2023.
//

import Foundation

//  MARK: - Protocol

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // happy path response
    func didFailToLoadData(with error: Error) // unhappy path response
}
