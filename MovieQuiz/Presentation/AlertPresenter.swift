//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import UIKit

// MARK: - Protocol

protocol AlertPresenterProtocol: AnyObject {
	func show(for model: AlertModel)
}

final class AlertPresenter {
    // MARK: - Properties
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension AlertPresenter: AlertPresenterProtocol {
    // MARK: - Methods
    
    func show(for model: AlertModel) {
        
        // init the alert
        let alert = UIAlertController(
            title: model.title,
            message: model.text,
            preferredStyle: .alert)

		// set label for UI tests
		alert.view.accessibilityIdentifier = "Alert"
        
        // init the button
        let action = UIAlertAction(
            title: model.buttonText,
            style: .default) { _ in
                model.completion()
            }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true)
    }
}
