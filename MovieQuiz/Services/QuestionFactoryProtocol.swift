//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 16.05.2023.
//

import Foundation

//  MARK: - Protocols

/// A protocol for all Factories that can work with `QuizQuestion` structure
protocol QuestionFactoryProtocol {    
    func requestNextQuestion()
    func loadData()
}
