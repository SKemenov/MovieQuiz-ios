import UIKit

final class MovieQuizViewController: UIViewController {
    //     MARK: - Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    
    //  MARK: - Properties
    
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    private let questionsAmount: Int = 10

    private var currentQuestion: QuizQuestion?

    private var questionFactory: QuestionFactoryProtocol?
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticService?
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertPresenter = AlertPresenter(viewController: self)
        questionFactory = QuestionFactory(delegate: self, moviesLoader: MovieLoader())
        statisticService = StatisticServiceImplementation()
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()

        questionFactory?.loadData()
        resetRound()
    }
    
    
    // MARK: - Actions

    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion else { return }
        showAnswerResult(isCorrect: currentQuestion.correctAnswer ? true : false)
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion else { return }
        showAnswerResult(isCorrect: !currentQuestion.correctAnswer ? true : false)
    }
    
    // MARK: - Methods

    private func resetRound() {
        // make a border's properties for the first question the same as in the Firma protopype
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 20
        
        // reset score properties
        currentQuestionIndex = 0
        correctAnswers = 0
        
        questionFactory?.requestNextQuestion()
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    /// A private method  to perpesent data from the question viewModel into UI elements
    private func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = ( isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor )
        
        enableButtons(false)
        
        correctAnswers += ( isCorrect ? 1 : 0 )
        
        // wait 1 sec after that enable buttons and go next to run the closure
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) { [weak self] in
            guard let self else { return }
            self.showNextQuestionOrResults()
        }
    }
    
    /// A private method to enable (or disable) Yes and No buttons
    private func enableButtons(_ state: Bool) {
        yesButton.isEnabled = state
        noButton.isEnabled = state
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
             showFinalResults()
        } else {
            currentQuestionIndex += 1
            imageView.layer.borderColor = UIColor.clear.cgColor
            imageView.image = UIImage() // clear movie's poster before loading the next one
            loadingIndicator.startAnimating()
            
            questionFactory?.requestNextQuestion()
        }
    }
    
    private func showFinalResults() {
        statisticService?.store(correct: correctAnswers, total: questionsAmount)
        
        let alertModel = AlertModel(
            title: "Этот раунд окончен!",
            text: makeResultsMessage(),
            buttonText: "Сыграть ещё раз",
            completion: { [weak self ] in
                self?.resetRound()
            }
        )
        alertPresenter?.show(for: alertModel)
    }
    
    private func makeResultsMessage() -> String {
                
        guard let statisticService = statisticService,
              let bestGame = statisticService.bestGame else {
            assertionFailure("error message")
            return ""
        }
     
        let currentGameResultLine = "Ваш результат: \(correctAnswers)/\(questionsAmount)"
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        let bestGameLine = "Рекорд: \(bestGame.correct)/\(bestGame.total) (\(bestGame.date.dateTimeString))"
        let accuracy = String(format: "%.2f", statisticService.totalAccuracy)
        let averageAccuracyLine = "Средняя точность: \(accuracy)%"
        let resultMessage = [currentGameResultLine, totalPlaysCountLine, bestGameLine, averageAccuracyLine].joined(separator: "\n")
        
        return resultMessage
    }
        
    private func showNetworkError(message: String) {
        
        let alertModel = AlertModel(
            title: "Ошибка",
            text: message,
            buttonText: "Попробовать ещё раз",
            completion: { [weak self ] in
                guard let self else { return }
                self.questionFactory?.loadData()
            }
        )
        alertPresenter?.show(for: alertModel)
    }
    
}

// MARK: - Extensions

extension MovieQuizViewController: QuestionFactoryDelegate {
    
    func didLoadDataFromServer() {
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        showNetworkError(message: error.localizedDescription)
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question else { return }

        currentQuestion = question
        let viewModel = convert(model: question)

        // use async to show updated UI
        DispatchQueue.main.async { [weak self] in
            self?.enableButtons(true)
            self?.loadingIndicator.stopAnimating()
            self?.show(quiz: viewModel)
        }
    }
}

