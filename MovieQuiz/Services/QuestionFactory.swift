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
/// - term **func requestNextQuestion() -> QuizQuestion?**: A method to request all necessary data for the next question.

class QuestionFactory: QuestionFactoryProtocol {
    // MARK: - Constants & Variables
    //
    //

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
    /// A method to request all necessary data for the next question.
    ///
    /// - Returns: an optional - `QuizQuestion` structure if it possible to request ot `nil`
    func requestNextQuestion() -> QuizQuestion? {
        /// It gets an index as a random number from the range from 0 to the end of questions array
        guard let index = (0..<questions.count).randomElement() else { return nil }
        
        // try to return a record from questions array with current index or return nil
        return questions[safe: index]
    }
    
    
    
}
