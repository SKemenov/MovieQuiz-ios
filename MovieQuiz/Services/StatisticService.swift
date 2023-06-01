//
//  StatiscticService.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 27.05.2023.
//

import Foundation

protocol StatisticService {
    
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: BestGame? { get }
    
    func store(correct count: Int, total amount: Int)
}


final class StatisticServiceImplementation {

    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }

    private let userDefaults: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let dateProvider: () -> Date

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
    
        
extension StatisticServiceImplementation: StatisticService {

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
        Double (total > 0 ? correct / total * 100 : 0)
    }
    
    var bestGame: BestGame? {
        get {
            guard
                let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                let bestGame = try? decoder.decode(BestGame.self, from: data)
            else {
                return nil
            }
            print(bestGame)
            return bestGame
        }
        set {
            let data = try? encoder.encode(newValue)
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        self.correct +=  correct
        self.total += total
        self.gamesCount += 1
        
        let date = dateProvider()
        let currentBestGame = BestGame(correct: correct, total: total, date: date)
        if let previusBestGame = bestGame {
            if currentBestGame > previusBestGame {
                bestGame = currentBestGame
            } else {
                bestGame = currentBestGame
            }
        }
    }
    
    
    
    
//    var totalAccuracy: Double {
//        get {
//            guard let data = userDefaults.data(forKey: Keys.correct.rawValue),
//                  let correct = try? JSONDecoder().decode(Double.self, from: data) else {
//                return 0
//            }
//            return correct
//        }
//        set {
//            guard let data = try? JSONEncoder().encode(newValue) else {
//                print("Невозможно сохранить результат")
//                return
//            }
//            userDefaults.set(data, forKey: Keys.correct.rawValue)
//        }
//    }
//
//    var gamesCount: Int {
//        get {
//            guard let data = userDefaults.data(forKey: Keys.gamesCount.rawValue),
//                  let gamesCount = try? JSONDecoder().decode(Int.self, from: data) else {
//                return 0
//            }
//            return gamesCount
//        }
//        set {
//            guard let data = try? JSONEncoder().encode(newValue) else {
//                print("Невозможно сохранить результат")
//                return
//            }
//            userDefaults.set(data, forKey: Keys.gamesCount.rawValue)
//        }
//    }
//
//    var bestGame: GameRecord {
//
//        get {
//            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
//                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
//                return .init(correct: 0, total: 0, date: Date())
//            }
//            return record
//        }
//
//        set {
//            guard let data = try? JSONEncoder().encode(newValue) else {
//                print("Невозможно сохранить результат")
//                return
//            }
//            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
//        }
//    }
//
}
