//
//  MovieQuizPresenterTests.swift
//  MovieQuizPresenterTests
//
//  Created by Sergey Kemenov on 23.06.2023.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
	func show(quiz step: MovieQuiz.QuizStepViewModel) {
	}

	func enableButtons(_ state: Bool) {
	}

	func prepareViewForNextQuestion() {
	}

	func prepareViewAfterAnswer(isCorrectAnswer: Bool) {
	}

	func showFinalResults() {
	}

	func showNetworkError(message: String) {
	}
}

final class MovieQuizPresenterTests: XCTestCase {
	func testPresenterConvertModel() throws {
		// Given
		let viewControllerMock = MovieQuizViewControllerMock()
		var presenter = MovieQuizPresenter(viewController: viewControllerMock)

		// When
		let emptyData = Data()
		let question =  QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
		let viewModel = presenter.convert(model: question)

		// Then
		XCTAssertNotNil(viewModel.image)
		XCTAssertEqual(viewModel.text, "Question Text")
		XCTAssertEqual(viewModel.questionNumber, "1/10")
	}

}
