//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Sergey Kemenov on 19.06.2023.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
	var app: XCUIApplication!

	override func setUpWithError() throws {
		try super.setUpWithError()

		app = XCUIApplication()
		app.launch()

		// In UI tests it is usually best to stop immediately when a failure occurs.
		continueAfterFailure = false
	}

	override func tearDownWithError() throws {
		try super.tearDownWithError()

		app.terminate()
		app = nil
	}

	func testYesButtonLoadingPosters() throws {
		sleep(2)

		let firstPoster = app.images["Poster"] // Get UI element
		let firstPosterData = firstPoster.screenshot().pngRepresentation // Get image from UI Element

		XCTAssertTrue(firstPoster.exists)

		app.buttons["Yes"].tap()
		sleep(2)

		XCTAssertEqual(app.staticTexts["Index"].label, "2/10")

		let secondPoster = app.images["Poster"]
		let secondPosterData = secondPoster.screenshot().pngRepresentation

		XCTAssertTrue(secondPoster.exists)

		XCTAssertNotEqual(firstPosterData, secondPosterData)
	}

	func testNoButtonLoadingPosters() throws {
		sleep(2)

		let firstPoster = app.images["Poster"]
		let firstPosterData = firstPoster.screenshot().pngRepresentation

		XCTAssertTrue(firstPoster.exists)

		app.buttons["No"].tap()
		sleep(2)

		XCTAssertEqual(app.staticTexts["Index"].label, "2/10")

		let secondPoster = app.images["Poster"]
		let secondPosterData = secondPoster.screenshot().pngRepresentation

		XCTAssertTrue(secondPoster.exists)

		XCTAssertNotEqual(firstPosterData, secondPosterData)
	}

	func testIndex()  {
		sleep(4)
		app.buttons["Yes"].tap()
		sleep(3)

		XCTAssertEqual(app.staticTexts["Index"].label, "2/10")
	}

	func testAlertShowing() {
		sleep(5)
		for _ in 1...10 {
			sleep(4)
			app.buttons["Yes"].tap()
		}

		XCTAssertEqual(app.staticTexts["Index"].label, "10/10")

		sleep(3)
		let alert = app.alerts["Alert"]

		XCTAssertTrue(alert.exists)
		XCTAssertEqual(alert.label, "Этот раунд окончен!")
	}

	func testAlertDismiss() {
		sleep(5)
		for _ in 1...10 {
			sleep(4)
			app.buttons["Yes"].tap()
		}

		XCTAssertEqual(app.staticTexts["Index"].label, "10/10")

		sleep(3)
		let alert = app.alerts["Alert"]
		XCTAssertTrue(alert.exists)

		alert.buttons.firstMatch.tap()
		sleep(3)

		XCTAssertFalse(alert.exists)
		XCTAssertEqual(app.staticTexts["Index"].label, "1/10")
	}
}
