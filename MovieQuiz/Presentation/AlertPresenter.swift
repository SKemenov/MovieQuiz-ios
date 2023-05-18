//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation
import UIKit

/*
 В классе MovieQuizViewController есть метод show(quiz result: QuizResultsViewModel). Он отвечает за отображение алерта (окошка с уведомлением) с результатами квиза после прохождения всех вопросов. Но задача отображения другого экрана (алерт в некотором смысле он и есть) похожа на то, что не обязательно должен делать именно MovieQuizViewController.
 Вынесите эту логику в отдельный класс AlertPresenter. Для передачи данных для отображения создайте структуру AlertModel в отдельном файле и сохраните его в папке Models.
 Структура AlertModel должна содержать:
 текст заголовка алерта title
 текст сообщения алерта message
 текст для кнопки алерта buttonText
 замыкание без параметров для действия по кнопке алерта completion
 Файл AlertPresenter.swift положите в папку Presentation.
 */

class AlertPresenter: UIViewController {
    //  MARK: - Variables, Constants
    //
//    ///
//    private var currentQuestionIndex: Int = 0
//    /// A variable with total amound of player's correct answers
//    private var correctAnswers: Int = 0
//    /// A constant with total amound of questions for each round
//    private let questionsAmount: Int = 10
//    /// A constant compatible with`QuestionFactoryProtocol` to provide access to this Factory
//    private var questionFactory: QuestionFactoryProtocol?
//    /// An optional variable with data of the current question
//    /// - important: Use `guard-let` or `if-let` to unwrap the value of this optional
//    /// - returns: `QuizQuestion` strucrure or `nil`
//    private var currentQuestion: QuizQuestion?

    // MARK: - Methods
    //
    //
    
//    /// A callback method to receive question from the delegate.
//    /// - Parameter question: `QuizQuestion` structure with the question or `nil`
//    func didReceiveNextQuestion(question: QuizQuestion?) {
//        /// while receiving `nil` return without updating UI
//        guard let question = question else { return }
//        currentQuestion = question
//        let viewModel = convert(model: question)
//        // use async to show updated UI
//        DispatchQueue.main.async { [weak self] in
//            self?.show(quiz: viewModel)
//        }
//
//    }
  
    
//    /// A private method  to show an alert with quiz's result from resultsViewModel
//    private func show(quiz result: QuizResultsViewModel) {
//        
//        // Let's start with constants for the alert and the action
//        let alert = UIAlertController(
//            title: result.title,
//            message: result.text,
//            preferredStyle: .alert)
//        
//        // prepare the action (a button) and to-do steps for the afterparty
//        let action = UIAlertAction(
//            title: result.buttonText,
//            style: .default) { [weak self] _ in // <- here starting the closure - what exactly need to do after clicking the alert button
//                
//                // use weak in closure, so need to add `guard-let` for weak link, in this case `weak` is `self`
//                guard let self = self else { return }
//                
//                // reset Index's and Score's global variables
//                self.currentQuestionIndex = 0
//                self.correctAnswers = 0
//                
//                // load the first question and show it
//                self.questionFactory?.requestNextQuestion()
//                
//                // hide the border around the image after showing the first question
//                self.imageView.layer.borderWidth = 0
//            }
//        
//        // combine the alert and the action
//        alert.addAction(action)
//        
//        // show the final scene - the alert with the action
//        self.present(alert, animated: true, completion: nil)
//    }

}
