//
//  StatiscticService.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 27.05.2023.
//

import Foundation

// MARK: - Protocol

/// A protocol to CDUR the information about game score
protocol StatisticService {
    
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: BestGame? { get }
    
    func store(correct count: Int, total amount: Int)
}

// MARK: - Class

/// A classe to work with the information about game score
final class StatisticServiceImplementation {

    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }

    private let userDefaults: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let dateProvider: () -> Date

    // MARK: - init
    init(
        userDefaults: UserDefaults = .standard,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder(),
        dateProvider: @escaping () -> Date = { Date() }
    ) {
        self.userDefaults = userDefaults
        self.decoder = decoder
        self.encoder = encoder
        self.dateProvider = dateProvider
    }

}
    
    // conform class to protocol
extension StatisticServiceImplementation: StatisticService {
    
    // MARK: - Extention's Properties

    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
        
    var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }

    var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }

    var totalAccuracy: Double {
        Double (correct) / Double(total) * 100.0
    }
    
    var bestGame: BestGame? {
        get {
            guard
                let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                let bestGame = try? decoder.decode(BestGame.self, from: data)
            else {
                return nil
            }
            return bestGame
        }
        set {

            guard let data = try? encoder.encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    // MARK: - Extention's Functions

    /// A method to collect and store the game score, and if it needs update info about the best game
    func store(correct count: Int, total amount: Int) {
        self.correct += count
        self.total += amount
        self.gamesCount += 1
        
        let date = dateProvider()
        let currentBestGame = BestGame(correct: count, total: amount, date: date)
        
        if let previusBestGame = bestGame {
            if currentBestGame > previusBestGame {
                bestGame = currentBestGame
            }
        } else {
            bestGame = currentBestGame
        }
    }
}
