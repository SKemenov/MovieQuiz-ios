//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation

//  MARK: - Class

class QuestionFactory: QuestionFactoryProtocol {
    // MARK: - Constants & Variables

    private weak var delegate: QuestionFactoryDelegate?
        private let moviesLoader: MoviesLoading
    
    private var movies: [MostPopularMovie] = []

    // MARK: - init
    init(delegate: QuestionFactoryDelegate?, moviesLoader: MoviesLoading) {
        self.delegate = delegate
        self.moviesLoader = moviesLoader
    }
    
    // MARK: - Methods

    func requestNextQuestion()  {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            guard let movie = movies.randomElement() else {
                //assertionFailure("question is empty")
                return
            }
            
            var imageData = Data()
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
            }
            catch {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.didFailToLoadData(with: error)
                }
            }
            
            let question = makeQuestionWith(rating: movie.rating, imageData: imageData)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    
    private func makeQuestionWith(rating: String, imageData: Data) -> QuizQuestion {
        let rating = Float(rating) ?? 0
        // set range for the text closer to the rating or to the limits (4...9)
        let lessThanRating = rating < 4 ? 4 : Int(rating) - 2
        let moreThanRating = rating > 7 ? 9 : Int(rating) + 2
        let ratingLevel = (lessThanRating...moreThanRating).randomElement() ?? 0
        
        let text: String
        let correctAnswer: Bool
        
        if Bool.random() {
            text = "Рейтинг этого фильма больше \(ratingLevel)?"
            correctAnswer = rating > Float(ratingLevel)
        } else {
            text = "Рейтинг этого фильма меньше \(ratingLevel)?"
            correctAnswer = rating < Float(ratingLevel)
        }
        
        let question = QuizQuestion(image: imageData,
                                    text: text,
                                    correctAnswer: correctAnswer)
        return question
    }

    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                    case .success(let mostPopularMovies):
                        self.movies = mostPopularMovies.items
                        self.delegate?.didLoadDataFromServer()
                    case .failure(let error):
                        self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    }
}
