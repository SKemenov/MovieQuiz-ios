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

class AlertPresenter: UIViewController, AlertPresenterProtocol {
    //  MARK: - Variables, Constants
    //
     /// A delegate variable using to delegate from viewController
    weak var delegate: AlertPresenterDelegate?

private var alert: AlertModel?
    // MARK: - Methods
    //
    //
    
 /// A default init for `AlertPresenter` class with a delegate
    ///
    /// - Parameter delegate: A delegate to init the presenter
    init(delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
  
        /// A method to request all necessary data for the next question.
    ///
    /// After requesting the question data using the delegate's callback method to load `QuizQuestion` structure into UI
    /// - Returns: the #2 version of the method has no returns
    /// - version: v.2 using the delegate to update the UI
    /// - Postcondition: used delegate's `didReceiveNextQuestion()` callback method
    func requestAlert()  {
        /// create half-opened range -  from 0 to the end of questions array - 1
        let range = 0..<questions.count
        /// It gets an index as a random number from the range. If has no index, send nil into the delegate and return from the method
        guard let index = range.randomElement() else {
            delegate?.didReceiveNextQuestion(question: nil)
            return
        }
        
        // try to receive a record from questions array with current index or return nil
         alert = AlertModel(
        /// put `QuizQuestion` structure into the delegate's callback method
        delegate?.didReceiveAlertFor(alert: alert)
    }
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
