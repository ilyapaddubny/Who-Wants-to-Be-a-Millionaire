//
//  VoteAudienceViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by VASILY IKONNIKOV on 02.03.2024.
//

import UIKit

enum QuestionDifficulty {
	case easy, hard
}

protocol VoteAudienceViewControllerDelegate: AnyObject {
	func getCorrectAnswer(_ viewController: VoteAudienceViewController) -> Int
	func getQuestionDifficulty(_ viewController: VoteAudienceViewController) -> QuestionDifficulty
}

class VoteAudienceViewController: UIViewController {

	weak var delegate: VoteAudienceViewControllerDelegate?
	
	private var votePercentages: [Int] = [0, 0, 0, 0]
	private var correctAnswerIndex: Int? = 1
	private var questionDifficulty: QuestionDifficulty? = .easy
	private var votingGraphView = VotingGraphView()
	
	private lazy var backgroundImage: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "background_empty")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupCorrectAnswer()
		setupQuestionDifficulty()
		votingGraphView.delegate = self
		
		generateVoteData(with: correctAnswerIndex)
		addSubviews()
		setupVotingGraphView()
		setupConstraints()
    }

	private func setupCorrectAnswer() {
		if let correctAnswer = delegate?.getCorrectAnswer(self) {
			self.correctAnswerIndex = correctAnswer
		}
	}
	
	private func setupQuestionDifficulty() {
		if let questionDifficulty = delegate?.getQuestionDifficulty(self) {
			self.questionDifficulty = questionDifficulty
		}
	}

}

// MARK: - Vote Data Generation
extension VoteAudienceViewController {
	// Выбор с какой вероятностью будет произведен выбор аудитории
	private func determineCorrectChoiceProbability() -> Int {
		switch questionDifficulty {
		case .easy:
			return 70
		case .hard:
			return 50
		case .none:
			return 50
		}
	}
	
	// Определяет, выберет ли аудитория правильный ответ
	private func willAudienceChooseCorrectly(with probability: Int) -> Bool {
		let totalProbability = 100
		let probabilitySample = Int.random(in: 1...totalProbability)
		return probabilitySample < probability
	}

	// Распределяет оставшиеся проценты для неправильных ответов.
	private func generateOtherPercentage(firstRandom: Int) -> [Int] {
		var remainingPercentage = 100 - firstRandom
		var percentages: [Int] = []
		for _ in 0..<2 {
			let randomPercentage = Int.random(in: 0...remainingPercentage)
			percentages.append(randomPercentage)
			remainingPercentage -= randomPercentage
		}
		percentages.append(remainingPercentage)
		return percentages
	}

	private func generateVoteData(with correctAnswerIndex: Int?) {
		let correctChoiceProbability = determineCorrectChoiceProbability()
		let willAudienceChooseCorrectly = willAudienceChooseCorrectly(with: correctChoiceProbability)

		let correctAnswerPercentage = willAudienceChooseCorrectly ? Int.random(in: 51...100) : Int.random(in: 0...50)
		let otherAnswersPercentage = generateOtherPercentage(firstRandom: correctAnswerPercentage)
		
		// Установка процентов голосов
		var index = 0
		for i in 0..<4 {
			if i == correctAnswerIndex {
				votePercentages[i] = correctAnswerPercentage
			} else {
				votePercentages[i] = otherAnswersPercentage[index]
				index += 1
			}
		}
	}
}

// MARK: - VotingGraphViewDelegate
extension VoteAudienceViewController: VotingGraphViewDelegate {
	func votingGraphViewNeedsVotePercentages(_ votingGraphView: VotingGraphView) -> [Int] {
		return votePercentages
	}
}

// MARK: - Style and Constraints
private extension VoteAudienceViewController {
	func addSubviews() {
		view.addSubview(backgroundImage)
		view.addSubview(votingGraphView)
	}
	
	func setupVotingGraphView() {
		votingGraphView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
		votingGraphView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			votingGraphView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			votingGraphView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			votingGraphView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			votingGraphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			votingGraphView.heightAnchor.constraint(equalToConstant: 500),
		])
	}
}
