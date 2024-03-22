//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 22.06.2023.
//

import Foundation
import UIKit.UIImage

final class MovieQuizPresenter {
	// MARK: - Properties

	private let questionsAmount: Int = 10
	private var currentQuestionIndex: Int = 0
	private var correctAnswers: Int = 0

	private var questionFactory: QuestionFactoryProtocol?
	private var statisticService: StatisticService?
	private var currentQuestion: QuizQuestion?
	private var quizResults: QuizResultsViewModel?
	private weak var viewController: MovieQuizViewControllerProtocol?

	// MARK: - Init
	init(viewController: MovieQuizViewControllerProtocol?) {
		self.viewController = viewController
		questionFactory = QuestionFactory(delegate: self, moviesLoader: MovieLoader())
		statisticService = StatisticServiceImplementation()
	}

	// MARK: - Public Methods

	func clickedButton(isYes: Bool) {
		guard let currentQuestion else { return }
		let givenAnswer = isYes
		proceedWithAnswer(isCorrect: givenAnswer == currentQuestion.correctAnswer)
	}

	func restartGame() {
		currentQuestionIndex = 0
		correctAnswers = 0
		prepareForNextQuestion()
	}

	func reloadGame() {
		questionFactory?.loadData()
		restartGame()
	}

	func makeQuizResults() -> QuizResultsViewModel {
		QuizResultsViewModel(
            title: "Этот раунд окончен!",
            text: makeResultsMessage(),
            buttonText: "Сыграть ещё раз"
        )
	}

	// Have to be non-private for unit tests
	func convert(model: QuizQuestion) -> QuizStepViewModel {
		return QuizStepViewModel(
			image: UIImage(data: model.image) ?? UIImage(),
			question: model.text,
			questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
	}

	// MARK: - Private Methods

	private func isLastQuestion() -> Bool {
		currentQuestionIndex == questionsAmount - 1
	}

	private func switchToNextQuestion() {
		currentQuestionIndex += 1
		prepareForNextQuestion()
	}

	private func prepareForNextQuestion() {
		viewController?.showLoadingIndicator()
		viewController?.prepareViewForNextQuestion()
		questionFactory?.requestNextQuestion()
	}

	private func didAnswer(isCorrectAnswer: Bool) {
		if isCorrectAnswer {
			correctAnswers += 1
		}
	}

	private func proceedWithAnswer(isCorrect: Bool) {
		viewController?.prepareViewAfterAnswer(isCorrectAnswer: isCorrect)
		viewController?.enableButtons(false)
		didAnswer(isCorrectAnswer: isCorrect)

		// wait 1 sec after that enable buttons and go next to run the closure
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) { [weak self] in
			guard let self else { return }
			self.proceedToNextQuestionOrResults()
		}
	}

	private func proceedToNextQuestionOrResults() {
		if isLastQuestion() {
			storeResults()
			viewController?.showFinalResults()
		} else {
			switchToNextQuestion()
		}
	}

	private func storeResults() {
		guard let statisticService else { return }
		statisticService.store(correct: correctAnswers, total: questionsAmount)
	}

	private func makeResultsMessage() -> String {
		guard let statisticService = statisticService,
			  let bestGame = statisticService.bestGame else {
			assertionFailure("error message")
			return ""
		}
		let currentGameResultLine = "Ваш результат: \(correctAnswers)/\(questionsAmount)"
		let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
		let bestGameLine = "Рекорд: \(bestGame.correct)/\(bestGame.total) (\(bestGame.date.dateTimeString))"
		let accuracy = String(format: "%.2f", statisticService.totalAccuracy)
		let averageAccuracyLine = "Средняя точность: \(accuracy)%"
		let resultMessage = [currentGameResultLine, totalPlaysCountLine, bestGameLine, averageAccuracyLine].joined(separator: "\n")
		return resultMessage
	}
}

// MARK: - Delegate's Methods

extension MovieQuizPresenter: QuestionFactoryDelegate {
	func didLoadDataFromServer() {
		questionFactory?.requestNextQuestion()
	}

	func didFailToLoadData(with error: Error) {
		viewController?.showNetworkError(message: error.localizedDescription)
	}

	func didReceiveNextQuestion(question: QuizQuestion?) {
		guard let question else { return }
		currentQuestion = question
		let viewModel = convert(model: question)

		// use async to show updated UI
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
            self.viewController?.hideLoadingIndicator()
            self.viewController?.enableButtons(true)
            self.viewController?.show(quiz: viewModel)
		}
	}
}
