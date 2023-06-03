//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation

//  MARK: - Class

/// A `QuestionFactory` class is a Service (or a Factory)  to generate, load, store all information about questions.
class QuestionFactory: QuestionFactoryProtocol {
    // MARK: - Constants & Variables

    /// A delegate variable using to call a delegate from viewController. The best practice is to use `private` and `weak`.
    private weak var delegate: QuestionFactoryDelegate?
    
    // MARK: - Mock Data

    /// An array with all data for the questions
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            name: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            name: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            name: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            name: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
        // Fake movie to check loading empty UIImage()
        //        ,
        //        QuizQuestion(
        //            name: "Crazy",
        //            text: "Рейтинг этого фильма больше чем 6?",
        //            correctAnswer: false)
    ]
    
    // MARK: - init
    init(delegate: QuestionFactoryDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Methods

    /// A method to request all necessary data for the next question.
    func requestNextQuestion()  {
//        1st way (with index)
//        /// create half-opened range -  from 0 to the end of questions array - 1
//        let range = 0..<questions.count
//        /// It gets an index as a random number from the range. If has no index, send nil into the delegate and return from the method
//        guard let index = range.randomElement() else {
//            delegate?.didReceiveNextQuestion(question: nil)
//            assertionFailure("question is empty")
//            return
//        }
//
//        // try to receive a record from questions array with current index or return nil
//        let question = questions[safe: index]
        
//        2nd way
        guard let question = questions.randomElement() else {
            delegate?.didReceiveNextQuestion(question: nil)
            assertionFailure("question is empty")
            return
        }
        
        /// put `QuizQuestion` structure into the delegate's callback method
        delegate?.didReceiveNextQuestion(question: question)
    }

    
}
