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
        let expectation = expectation(description: "Loading expextation") // using this for waiting

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
        waitForExpectations(timeout: 2) // need to wait this time (in secs)
    }

    func testFailureLoading() throws {
        // Given
		let stubNetworkClient = StubNetworkClient(emulateError: true)
		let loader = MovieLoader(networkClient: stubNetworkClient)

        // When
		let expectation = expectation(description: "Loading Failure expextation")

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
		waitForExpectations(timeout: 2)


    }
}

struct StubNetworkClient: NetworkRouting {
    enum TestError: Error {
        case test
    }

    let emulateError: Bool

    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
		if emulateError {
			handler(.failure(TestError.test))
		} else {
			handler(.success(expectedResponse))
		}
    }

	private var expectedResponse: Data {
		"""
		{
		   "errorMessage" : "",
		   "items" : [
			  {
				 "crew" : "Dan Trachtenberg (dir.), Amber Midthunder, Dakota Beavers",
				 "fullTitle" : "Prey (2022)",
				 "id" : "tt11866324",
				 "imDbRating" : "7.2",
				 "imDbRatingCount" : "93332",
				 "image" : "https://m.media-amazon.com/images/M/MV5BMDBlMDYxMDktOTUxMS00MjcxLWE2YjQtNjNhMjNmN2Y3ZDA1XkEyXkFqcGdeQXVyMTM1MTE1NDMx._V1_Ratio0.6716_AL_.jpg",
				 "rank" : "1",
				 "rankUpDown" : "+23",
				 "title" : "Prey",
				 "year" : "2022"
			  },
			  {
				 "crew" : "Anthony Russo (dir.), Ryan Gosling, Chris Evans",
				 "fullTitle" : "The Gray Man (2022)",
				 "id" : "tt1649418",
				 "imDbRating" : "6.5",
				 "imDbRatingCount" : "132890",
				 "image" : "https://m.media-amazon.com/images/M/MV5BOWY4MmFiY2QtMzE1YS00NTg1LWIwOTQtYTI4ZGUzNWIxNTVmXkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_Ratio0.6716_AL_.jpg",
				 "rank" : "2",
				 "rankUpDown" : "-1",
				 "title" : "The Gray Man",
				 "year" : "2022"
			  }
			]
		  }
		""".data(using: .utf8) ?? Data()
	}
}
