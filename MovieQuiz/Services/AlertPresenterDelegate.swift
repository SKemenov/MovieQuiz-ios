//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

//  MARK: - Protocols
//
//
/// This's a delegate to control receiving alert's data from `AlertPresenter`.
///
/// To be compatible should implement `didReceiveAlertFor(alert:)` method.
protocol AlertPresenterDelegate: AnyObject {
    /// Request a delegate method for updating UI after loading the question.
    /// - Parameter alert: an alert or `nil`
    func didReceiveAlert(for model: AlertModel?)
}

