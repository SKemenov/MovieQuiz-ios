import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
	func show(quiz step: QuizStepViewModel)
	func prepareViewForNextQuestion()
	func prepareViewAfterAnswer(isCorrectAnswer: Bool)
	func showFinalResults()
	func showNetworkError(message: String)
}

final class MovieQuizViewController: UIViewController {
	//     MARK: - Outlets

	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var textLabel: UILabel!
	@IBOutlet private weak var counterLabel: UILabel!
	@IBOutlet private weak var yesButton: UIButton!
	@IBOutlet private weak var noButton: UIButton!
	@IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!


	//  MARK: - Properties

	private var alertPresenter: AlertPresenterProtocol?
	private var presenter: MovieQuizPresenter!


	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		alertPresenter = AlertPresenter(viewController: self)
		presenter = MovieQuizPresenter(viewController: self)

		loadingIndicator.hidesWhenStopped = true
		loadingIndicator.startAnimating()

		// Setup Labels  for UI elements for UI tests
		imageView.accessibilityIdentifier = "Poster"
		textLabel.accessibilityIdentifier = "Question"
		counterLabel.accessibilityIdentifier = "Index"
		yesButton.accessibilityIdentifier = "Yes"
		noButton.accessibilityIdentifier = "No"
		loadingIndicator.accessibilityIdentifier = "LoadingIndicator"

		imageView.layer.masksToBounds = true
		imageView.layer.borderWidth = 0
		imageView.layer.cornerRadius = 20

		presenter.restartGame()
	}


	// MARK: - Actions

	@IBAction private func yesButtonClicked(_ sender: UIButton) {
		presenter.didAnswer(isYes: true)
	}

	@IBAction private func noButtonClicked(_ sender: UIButton) {
		presenter.didAnswer(isYes: false)
	}

	// MARK: - Methods

	func show(quiz step: QuizStepViewModel) {
		counterLabel.text = step.questionNumber
		imageView.image = step.image
		textLabel.text = step.question
		
		loadingIndicator.stopAnimating()
		enableButtons(true)
	}

	func prepareViewForNextQuestion() {
		loadingIndicator.startAnimating()
		imageView.layer.borderColor = UIColor.clear.cgColor
		imageView.image = UIImage()
		textLabel.text = ""
	}

	func prepareViewAfterAnswer(isCorrectAnswer: Bool) {
		imageView.layer.borderWidth = 8
		imageView.layer.borderColor = ( isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor )
		enableButtons(false)
	}

	private func enableButtons(_ state: Bool) {
		yesButton.isEnabled = state
		noButton.isEnabled = state
	}

	func showFinalResults() {
		let alertModel = AlertModel(
			title: "Этот раунд окончен!",
			text: presenter.makeResultsMessage(),
			buttonText: "Сыграть ещё раз",
			completion: { [weak self ] in
				self?.presenter.restartGame()
			}
		)
		alertPresenter?.show(for: alertModel)
	}

	func showNetworkError(message: String) {
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			let alertModel = AlertModel(
				title: "Ошибка",
				text: message,
				buttonText: "Попробовать ещё раз",
				completion: { [weak self ] in
					guard let self else { return }
					self.presenter.restartGame()
				}
			)
			self.alertPresenter?.show(for: alertModel)
		}
	}
}
