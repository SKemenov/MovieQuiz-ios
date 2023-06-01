//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import UIKit


/// A class to show the result at the end of the round.
final class AlertPresenter {
    //  MARK: - Properties
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    
}

extension AlertPresenter: AlertPresenterProtocol {
    // MARK: - Methods
    
    /// A method to show the alert with data from `AlertModel` structure
    func requestAlert(for model: AlertModel)  {

        // init the alert
        let alert = UIAlertController(
            title: model.title,
            message: model.text,
            preferredStyle: .alert)
        
        // init the button
        let action = UIAlertAction(title: model.buttonText,
                                   style: .default) { _ in 
            model.completion()
        }
        
        // prepare the alert with button
        alert.addAction(action)
        
        // show the alert
        viewController?.present(alert, animated: true)
    }
}
