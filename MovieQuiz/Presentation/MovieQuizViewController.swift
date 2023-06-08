import UIKit


/// Main viewController of MovieQuiz
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
    /// A variable with total amound of player's correct answers
    private var correctAnswers: Int = 0
    /// A constant with total amound of questions for each round
    private let questionsAmount: Int = 10

    private var currentQuestion: QuizQuestion?

    private var questionFactory: QuestionFactoryProtocol?
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticService?
    
    
    // MARK: - Lifecycle
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertPresenter = AlertPresenter(viewController: self)
        questionFactory = QuestionFactory(delegate: self)
        statisticService = StatisticServiceImplementation()
        
        showLoadingIndicator(true)
        sleep(5)
        showNetworkError(message: "Невозможно загрузить данные")

        //resetRound()
        
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

    /// A method to reset the round (at the begining and before running the next round)
    func resetRound() {
        // make a border for the first question the same as in the Firma protopype
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 20
        
        // reset variables
        currentQuestionIndex = 0
        correctAnswers = 0
        
        // try to request the first question
        questionFactory?.requestNextQuestion()
    }
    
    /// A private method to convert QuizQuestion struct data into QuizStepViewModel's view model
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        // return image by the name or empty image as UIImage()
        return QuizStepViewModel(
            image: UIImage(named: model.name) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    /// A private method  to perpesent data from the question viewModel into UI elements
    private func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    
    /// A private method to show the answer result
    private func showAnswerResult(isCorrect: Bool) {
        
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = ( isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor )
        
        enableButtons(false)
        
        correctAnswers += ( isCorrect ? 1 : 0 )
        
        // wait 1 sec after that enable buttons and go next to run the closure
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) { [weak self] in
            guard let self else { return }
            self.enableButtons(true)
            self.showNextQuestionOrResults()
        }
    }
    
    /// A private method to enable (or disable) Yes and No buttons
    private func enableButtons(_ state: Bool) {
        yesButton.isEnabled = state
        noButton.isEnabled = state
    }
    
    /// A private method which showing the next question or the result alert at the end
    private func showNextQuestionOrResults() {
        
        // if it's the final question show the result's alert, otherwise - go the next question
        if currentQuestionIndex == questionsAmount - 1 {
             showFinalResults()
        } else {
            currentQuestionIndex += 1
            
            // hide the border (width=0) around the image before showing the next question
            imageView.layer.borderWidth = 0
            
            questionFactory?.requestNextQuestion()
        }
    }
    
    /// A private method to save final score and call an alert
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
    
    /// A private method to prepare and make the final score message
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
    
    private func showLoadingIndicator(_ status: Bool) {
        loadingIndicator.isHidden = status
        if status {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    private func showNetworkError(message: String) {
        showLoadingIndicator(false)
        
        let alertModel = AlertModel(
            title: "Ошибка",
            text: message,
            buttonText: "Попробовать ещё раз",
            completion: { [weak self ] in
                self?.resetRound()
            }
        )
        alertPresenter?.show(for: alertModel)
    }
    
}

// MARK: - Extensions
// conform to Protocol QuestionFactoryDelegate
extension MovieQuizViewController: QuestionFactoryDelegate {
    
    /// A delegate method to receive question from the factory's delegate.
    /// - Parameter question: `QuizQuestion` structure with the question or `nil`
    func didReceiveNextQuestion(question: QuizQuestion?) {
        
        /// while receiving `nil` return without updating UI
        guard let question else { return }
        currentQuestion = question
        let viewModel = convert(model: question)
        // use async to show updated UI
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
}

