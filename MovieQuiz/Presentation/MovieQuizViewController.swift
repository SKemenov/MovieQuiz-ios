import UIKit

final
class MovieQuizViewController: UIViewController {
    //     MARK: - Outlets
    //    Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var yesButtonClicked: UIButton!
    @IBOutlet private weak var noButtonClicked: UIButton!
    
    
    // MARK: - Structs
    //        Struct to hold all information about the question
    struct QuizQuestion {
        // picture name == movie name
        let name: String
        // question
        let text: String
        // rightAnswer
        let correctAnswer: Bool
    }
    
    //    Struct to hold information for the questionShowed of the state machine
    struct QuizStepViewModel {
        // picture
        let image: UIImage
        // question
        let question: String
        // question number of all (ex. "2/10")
        let questionNumber: String
    }
    
    struct QuizResultsViewModel {
        let title: String
        let text: String
        let buttonText: String
    }
    
    //  MARK: - Variables, Constants
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    
    // MARK: - Mock Data
    //    an array for the questions
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            name: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            name: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            name: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            name: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            name: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            name: "Crazy",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
    ]
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentQuestion = questions[currentQuestionIndex]
        let currentQuiz = convert(model: currentQuestion)
        show(quiz: currentQuiz)

    }
    
    
    // MARK: - Actions
    //    Action for the Yes button
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: questions[currentQuestionIndex].correctAnswer ? true : false)
    }
    
    //    Action for the No button
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: !questions[currentQuestionIndex].correctAnswer ? true : false)
    }
    
    // MARK: - Methods
    
    // Method to convert QuizQuestion struct data into QuizStepViewModel's view model
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        // return image by the name or empty image as UIImage()
        return QuizStepViewModel(
            image: UIImage(named: model.name) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
    }
    
    // Method to put data from the viewModel into UI elements
    private func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        
    }
    
    // Method to show the answer result
    private func showAnswerResult(isCorrect: Bool) {
        // show the result
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = ( isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor )
        correctAnswers += ( isCorrect ? 1 : 0 )
// wait 1 sec and show the next question
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
            self.showNextQuestionOrResults()
        }
    }
    
    
    // Method
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            // finish
            let alert = UIAlertController(
                title: "Этот раунд окончен!",
                message: "Ваш результат \(correctAnswers)/\(questions.count - 1)",
                preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Сыграть ещё раз", style: .default) { _ in
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                let firstQuestion = self.questions[self.currentQuestionIndex]
                let viewModel = self.convert(model: firstQuestion)
                self.show(quiz: viewModel)
           }
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            currentQuestionIndex += 1
            // next question
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            show(quiz: viewModel)
            print(correctAnswers)

        }
        imageView.layer.borderWidth = 0
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
