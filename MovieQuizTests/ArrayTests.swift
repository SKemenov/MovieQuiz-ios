//
//  ArrayTests.swift
//  ArrayTests
//
//  Created by Sergey Kemenov on 13.06.2023.
//

import XCTest
@testable import MovieQuiz // import our app for testing

final class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        // Given
        let array = [1, 2, 3, 4, 5]
        
        // When
        let value = array[safe: 2]
        
        //Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 3)
    }
    
    func testGetValueOutOfRange() {
        // Given
        let array = [1, 2, 3, 4, 5,]
        
        //When
        let value = array[safe: 7]
        
        //Then
        XCTAssertNil(value)
    }
}
