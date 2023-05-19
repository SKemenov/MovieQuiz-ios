import UIKit

/// Main viewController of MovieQuiz
final
class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    //     MARK: - Outlets
    //
    //
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    
    
    //  MARK: - Variables, Constants
    //
    ///
    private var currentQuestionIndex: Int = 0
    /// A variable with total amound of player's correct answers
    private var correctAnswers: Int = 0
    /// A constant with total amound of questions for each round
    private let questionsAmount: Int = 10
    
    /// An optional variable compatible with`QuestionFactoryProtocol` to provide access to this Factory
    /// - important: Use `guard-let` or `if-let` to unwrap the value of this optional
    private var questionFactory: QuestionFactoryProtocol?
    
    /// An optional variable with data of the current question
    /// - important: Use `guard-let` or `if-let` to unwrap the value of this optional
    /// - returns: `QuizQuestion` structure or `nil`
    private var currentQuestion: QuizQuestion?
    
    /// An optional variable compatible with `AlertPresenterProtocol` to provide access to `AlertPresenter` class
    /// - important: Use `guard-let` or `if-let` to unwrap the value of this optional
    private var alertPresenter: AlertPresenterProtocol?
    
    // MARK: - Lifecycle
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init the presenter
        alertPresenter = AlertPresenter(viewController: self)
        
        // init the factory
        questionFactory = QuestionFactory(delegate: self)
        
        // try to reset round and request the first question
        resetRound()
    }
    
    
    // MARK: - Actions
    //
    //
    /// An action for the Yes button
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion else { return }
        showAnswerResult(isCorrect: currentQuestion.correctAnswer ? true : false)
    }
    
    
    /// An action for the No button
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion else { return }
        showAnswerResult(isCorrect: !currentQuestion.correctAnswer ? true : false)
    }
    
    // MARK: - Methods
    //
    //
    
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
    
    // A method to reset the round (at the begining and before running the next round)
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
    ///
    /// The method update data for the following UI elements:
    ///  - `counterLabel`
    ///  - `imageView`
    ///  - `textLabel`
    ///
    /// - Parameter quiz: Data from the question viewModel
    private func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    
    
    /// A private method to show the answer result
    private func showAnswerResult(isCorrect: Bool) {
        
        // show a Border with 8px wide and Green (if win) of Red (if lose)
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = ( isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor )
        
        // disable buttons
        enableButtons(false)
        
        // Update the Score variable. If the answer is correct add 1, otherwise, nothing
        correctAnswers += ( isCorrect ? 1 : 0 )
        
        // wait 1 sec after that enable buttons and go next to show the next question
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
            
            // Init the model
            let alertModel = AlertModel(title: "Этот раунд окончен!",
                                        text: "Ваш результат \(correctAnswers)/\(questionsAmount)",
                                        buttonText: "Сыграть ещё раз",
                                        completion: resetRound
            )
            
            // request the alert, show the final scene - The End
            alertPresenter?.requestAlert(for: alertModel)
            
        } else {
            // show must go on!
            currentQuestionIndex += 1
            
            // hide the border (width=0) around the image before showing the next question
            imageView.layer.borderWidth = 0
            
            // prepare the next question and
            questionFactory?.requestNextQuestion()
        }
    }
}



/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
