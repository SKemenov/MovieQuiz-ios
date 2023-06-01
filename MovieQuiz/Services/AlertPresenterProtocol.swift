//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

//  MARK: - Protocols
/// A protocol for all alerts that can work with `AlertModel` structure
protocol AlertPresenterProtocol: AnyObject {
    
    func show(for model: AlertModel)
}


