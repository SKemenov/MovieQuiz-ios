//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 16.05.2023.
//

import Foundation

//  MARK: - Protocols

protocol QuestionFactoryProtocol {    
    func requestNextQuestion()
    func loadData()
}
