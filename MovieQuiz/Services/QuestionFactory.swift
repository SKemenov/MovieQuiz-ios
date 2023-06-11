//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 14.05.2023.
//

import Foundation

//  MARK: - Class

/// A `QuestionFactory` class is a Service (or a Factory)  to generate, load, store all information about questions.
class QuestionFactory: QuestionFactoryProtocol {
    // MARK: - Constants & Variables

    /// A delegate variable using to call a delegate from viewController. The best practice is to use `private` and `weak`.
    private weak var delegate: QuestionFactoryDelegate?
    
    private let moviesLoader: MoviesLoading
    
    private var movies: [MostPopularMovie] = []

    // MARK: - init
    init(delegate: QuestionFactoryDelegate?, moviesLoader: MoviesLoading) {
        self.delegate = delegate
        self.moviesLoader = moviesLoader
    }
    
    // MARK: - Methods

    /// A method to request all necessary data for the next question.
    func requestNextQuestion()  {

        // 3rd way
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
                print("Failed to load image from imageURL into imageData")
            }

            let rating = Float(movie.imDbRating) ?? 0
            
            let questionLevel = (1...9).randomElement() ?? 0
            let text = "Рейтинг этого фильма больше \(questionLevel)?"
            let correctAnswer = rating > Float(questionLevel)
            
            let question = QuizQuestion(image: imageData,
                                        text: text,
                                        correctAnswer: correctAnswer)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                self.delegate?.didReceiveNextQuestion(question: question)
            }
            
        }
    }

    /// A method to load json from IMDb API 
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
