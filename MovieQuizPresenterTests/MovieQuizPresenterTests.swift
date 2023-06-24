//
//  MovieQuizPresenterTests.swift
//  MovieQuizPresenterTests
//
//  Created by Sergey Kemenov on 23.06.2023.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
	func show(quiz step: QuizStepViewModel) { }
	func showFinalResults() { }
	func enableButtons(_ state: Bool) { }
	func prepareViewForNextQuestion() { }
	func prepareViewAfterAnswer(isCorrectAnswer: Bool) { }
	func showNetworkError(message: String) { }
	func showLoadingIndicator() { }
	func hideLoadingIndicator() { }
}

final class MovieQuizPresenterTests: XCTestCase {
	func testPresenterConvertModel() throws {
		// Given
		let viewControllerMock = MovieQuizViewControllerMock()
		var presenter = MovieQuizPresenter(viewController: viewControllerMock)
		let emptyData = Data()
		let question =  QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)

		// When
		let viewModel = presenter.convert(model: question)

		// Then
		XCTAssertNotNil(viewModel.image)
		XCTAssertEqual(viewModel.question, "Question Text")
		XCTAssertEqual(viewModel.questionNumber, "1/10")
	}
}
