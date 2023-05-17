//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation

//  MARK: - Classes
//
//

/// A `QuestionFactory` class is a Service (or a Factory)  to generate, load, store all information about questions.
///
/// This class compatible with `QuestionFactoryProtocol`
/// 
/// ### Properties
/// `QuestionFactory` has the following properties: an array with mock data - `questions: [QuizQuestion]`.
///
/// ### Methods
/// This class has the next private method:
///
/// - term **func requestNextQuestion()**: A method to request all necessary data for the next question.
///  - version: 2.0 with delegate

class QuestionFactory: QuestionFactoryProtocol {
    // MARK: - Constants & Variables
    //
    /// A delegate variable using to callback from viewController
    weak var delegate: QuestionFactoryDelegate?
    
    // MARK: - Mock Data
    //
    //
    /// An array with all data for the questions
    /// - Returns: a record of data by the `QuizQuestion` structure
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
    
    // MARK: - Methods
    //
    //
    /// A default init for `QuestionFactory` class with a delegate
    ///
    /// - Parameter delegate: A delegate to init the Factory
    init(delegate: QuestionFactoryDelegate) {
        self.delegate = delegate
    }
    

    /// A method to request all necessary data for the next question.
    ///
    /// After requesting the question data using the delegate's callback method to load `QuizQuestion` structure into UI
    /// - Returns: the #2 version of the method has no returns
    /// - version: v.2 using the delegate to update the UI
    /// - Postcondition: used delegate's `didReceiveNextQuestion()` callback method
    func requestNextQuestion()  {
        /// create half-opened range -  from 0 to the end of questions array - 1
        let range = 0..<questions.count
        /// It gets an index as a random number from the range. If has no index, send nil into the delegate and return from the method
        guard let index = range.randomElement() else {
            delegate?.didReceiveNextQuestion(question: nil)
            return
        }
        
        // try to receive a record from questions array with current index or return nil
        let question = questions[safe: index]
        /// put `QuizQuestion` structure into the delegate's callback method
        delegate?.didReceiveNextQuestion(question: question)
    }

    
}
