import UIKit

final
class MovieQuizViewController: UIViewController {
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
    //
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    
    // MARK: - Lifecycle
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the first question
        let currentQuestion = questions[currentQuestionIndex]
        let questionViewModel = convert(model: currentQuestion)
        show(quiz: questionViewModel)
        
        // make a border for the first question the same as in the Firma protopype
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 20
    }
    
    
    // MARK: - Actions
    //
    //
    //    Action for the Yes button
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: questions[currentQuestionIndex].correctAnswer ? true : false)
    }
    
    
    //    Action for the No button
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: !questions[currentQuestionIndex].correctAnswer ? true : false)
    }
    
    // MARK: - Methods
    //
    //
    /// Method to convert QuizQuestion struct data into QuizStepViewModel's view model
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        // return image by the name or empty image as UIImage()
        return QuizStepViewModel(
            image: UIImage(named: model.name) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
    }
    
    
    /// Method to put data from the question viewModel into UI elements
    private func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    
    
    /// Method to show quiz's result into resultsViewModel
    private func show(quiz result: QuizResultsViewModel) {
        
        // Let's start with constants for the alert and the action
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        
        // prepare the action (a button) and to-do steps for the afterparty
        let action = UIAlertAction(
            title: result.buttonText,
            style: .default) { [weak self] _ in // <- here starting the closure - what exactly need to do after clicking the alert button
                
                // use weak in closure, so need to add guard let for weak, in this case weak self
                guard let self = self else { return }
                
                // reset Index's and Score's global variables
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                
                // load the first question and show it
                let firstQuestion = self.questions[self.currentQuestionIndex]
                let questionViewModel = self.convert(model: firstQuestion)
                self.show(quiz: questionViewModel)
                
                // hide the border around the image after showing the first question
                self.imageView.layer.borderWidth = 0
            }
        
        // combine the alert and the action
        alert.addAction(action)
        
        // show the final scene - the alert with the action
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// Method to show the answer result
    private func showAnswerResult(isCorrect: Bool) {
        
        // allow to show a Border, 8px wide, with corners' radius 20px, and Green (if win) of Red (if lose)
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = ( isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor )
        
        // disable buttons
        enableButtons(false)
        
        // Update the Score variable. If the answer is correct add 1, otherwise, nothing
        correctAnswers += ( isCorrect ? 1 : 0 )
        
        // wait 1 sec after that enable buttons and go next to show the next question
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) { [weak self] in
            guard let self = self else { return }
            self.enableButtons(true)
            self.showNextQuestionOrResults()
        }
    }
    
    /// Method do enable (or disable) Yes and No buttons
    private func enableButtons(_ state: Bool) {
        yesButton.isEnabled = state
        noButton.isEnabled = state
    }
    
    
    /// Method which showing the next question or the result alert at the end
    private func showNextQuestionOrResults() {
        // if it not the end go the next question, otherwise - show the final scene
        if currentQuestionIndex == questions.count - 1 {
            
            // Let's start with constants for the alert's title, message and the button's label
            let resultsViewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: "Ваш результат \(correctAnswers)/\(questions.count)",
                buttonText: "Сыграть ещё раз")
            
            // show the final scene - The End
            show(quiz: resultsViewModel)
            
        } else {
            // show must go on!
            currentQuestionIndex += 1
            
            // prepare the next question and
            let nextQuestion = questions[currentQuestionIndex]
            let questionViewModel = convert(model: nextQuestion)
            show(quiz: questionViewModel)
            
            // hide the border around the image before showing the next question
            imageView.layer.borderWidth = 0
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
