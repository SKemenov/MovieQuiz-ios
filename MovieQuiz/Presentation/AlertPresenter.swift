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
    /// An optional variable using to init a viewController
    private weak var viewController: UIViewController?
 
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    private var alert: AlertModel?
    // MARK: - Methods
    //
    //
    
    func requestAlert(for model: AlertModel)  {
     
        let alert = UIAlertController(
            title: model.title,
            message: model.text,
            preferredStyle: .alert)

        let action = UIAlertAction(
            title: model.buttonText,
            style: .default) { 
                print("1")
                model.completion 
            }
        
        alert.addAction(action)
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}
