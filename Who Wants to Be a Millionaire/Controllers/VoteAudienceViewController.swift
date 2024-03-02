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
	private var correctAnswerIndex: Int?
	private var questionDifficulty: QuestionDifficulty?
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
		
		addSubviews()
		setupVotingGraphView()
		setupConstraints()
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
