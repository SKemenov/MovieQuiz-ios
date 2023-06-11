//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

//  MARK: - Protocol

protocol AlertPresenterProtocol: AnyObject {
    func show(for model: AlertModel)
}


