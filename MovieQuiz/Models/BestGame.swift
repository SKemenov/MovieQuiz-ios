//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 30.05.2023.
//

import Foundation

struct BestGame: Codable {
    let correct: Int
    let total: Int
    let date: Date
}

extension BestGame: Comparable {
    // MARK: - Properties
    private var accuracy: Double {
        // checking dividing by zero
        guard total != 0 else {
            return 0
        }
        // total questions can be different, so it's better to use accuracy
        return Double(correct) / Double(total)
    }
    
    // MARK: - Functions
    static func < (lhs: BestGame, rhs: BestGame) -> Bool {
            lhs.accuracy < rhs.accuracy
        }
}
