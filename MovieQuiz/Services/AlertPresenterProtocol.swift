//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

//  MARK: - Protocols
//
//
///// A protocol for all alerts that can work with `AlertModel` structure
/////
///// The protocol has `requestAlert()` method
/////  - important: The method has no returns because `AlertPresenterDelegate` is available.
protocol AlertPresenterProtocol {
  func requestAlert()
}


