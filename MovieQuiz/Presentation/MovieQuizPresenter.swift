//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 22.06.2023.
//

import Foundation
import UIKit.UIImage

final class MovieQuizPresenter {
	//  MARK: - Properties
	
	let questionsAmount: Int = 10
	private var currentQuestionIndex: Int = 0
	var currentQuestion: QuizQuestion?
	weak var viewController: MovieQuizViewController?
	
	
	// MARK: - Methods
	
	func yesButtonClicked() {
		guard let currentQuestion else { return }
		viewController?.showAnswerResult(isCorrect: currentQuestion.correctAnswer ? true : false)
	}

	func noButtonClicked() {
		guard let currentQuestion else { return }
		viewController?.showAnswerResult(isCorrect: !currentQuestion.correctAnswer ? true : false)
	}
	
	func isLastQuestion() -> Bool {
		currentQuestionIndex == questionsAmount - 1
	}
	
	func resetQuestionIndex() {
		currentQuestionIndex = 0
	}
	
	func swithToNextQuestion() {
		currentQuestionIndex += 1
	}
	
	func convert(model: QuizQuestion) -> QuizStepViewModel {
		return QuizStepViewModel(
			image: UIImage(data: model.image) ?? UIImage(),
			question: model.text,
			questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
	}
}
