//
//  MovieQuizTests.swift
//  MovieQuizTests
//
//  Created by Sergey Kemenov on 13.06.2023.
//

import XCTest
@testable import MovieQuiz // import our app for testing

final class MoviesLoaderTests: XCTestCase {

    func testSuccessLoading() throws {
        //Given
		let stubNetworkClient = StubNetworkClient(emulateError: false)
		let loader = MovieLoader(networkClient: stubNetworkClient)

        //When
//        let expectation = expectation(description: "Loading expextation") // using this for waiting
		let expectation = XCTestExpectation(description: "Loading expextation") // for multiple tests better to use XCTestExpectation

        loader.loadMovies { result in
            // Then
            switch result {
                case .success(let movies):
					XCTAssertEqual(movies.items.count, 2)
                    expectation.fulfill()
                case .failure(_):
                    XCTFail("Unexpected failure")
            }
        }
//        waitForExpectations(timeout: 2) // need to wait this time (in secs)
		wait(for: [expectation], timeout: 2) // use with XCTestExpectation
    }

    func testFailureLoading() throws {
        // Given
		let stubNetworkClient = StubNetworkClient(emulateError: true)
		let loader = MovieLoader(networkClient: stubNetworkClient)

        // When
//		let expectation = expectation(description: "Loading Failure expextation")
		let expectation = XCTestExpectation(description: "Loading Failure expextation")

		loader.loadMovies { result in
			// Then
			switch result {
				case .failure(let error):
					XCTAssertNotNil(error)
					expectation.fulfill()
				case .success(_):
					XCTFail("Unexpected failure")
			}
		}
//		waitForExpectations(timeout: 2)
		wait(for: [expectation], timeout: 2)
    }
}
