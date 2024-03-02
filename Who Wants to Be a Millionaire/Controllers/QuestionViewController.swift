//
//  QuestionViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Александр Крапивин on 27.02.2024.
//

import UIKit




class QuestionViewController: UIViewController {
    
    let amountOfMoneyInInts: [Int] = [
        100,
        200,
        300,
        500,
        1000,
        2000,
        4000,
        8000,
        16000,
        32000,
        64000,
        125000,
        250000,
        500000,
        1000000
    ]
    
    var viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupProgressBarConstraints()
        startProgressBarAnimation()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backgroungImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "background_crowd")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var mainStackView = UIStackView()
    private var headerStackView = UIStackView()
    private var variantsStackView = UIStackView()
    private var footerStackView = UIStackView()
    
    private lazy var questionNumberLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 22)
        element.textColor = .white
        element.textAlignment = .center
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressTintColor = .yellow
        progressBar.trackTintColor = .black
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    private var timer: Timer?
    private var progress: Float = 1.0
    private let duration: TimeInterval = 30.0 // Total duration in seconds
    
    private lazy var logo: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "logo")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var actualSumLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 22)
        element.textColor = .white
        element.textAlignment = .center
        element.numberOfLines = 0
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var questionView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var questionBackgroundImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "question_rectangle")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var questLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 22)
        element.textAlignment = .center
        element.textColor = .white
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    private lazy var answerA: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(named: "question_empty"), for: .normal)
        
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var answerB: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(named: "question_empty"), for: .normal)
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var answerC: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(named: "question_empty"), for: .normal)
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var answerD: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(named: "question_empty"), for: .normal)
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    private lazy var halfHelp: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(viewModel.hasFiftyFiftyUsed ? UIImage(named: "help_50_50_crossed") : UIImage(named: "help_50_50"), for: .normal)
        element.isEnabled = !viewModel.hasFiftyFiftyUsed
        element.contentMode = .scaleAspectFit
        element.addTarget(self, action: #selector(fiftyFiftyButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var callHelp: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(viewModel.hasFriendCallUsed ? UIImage(named: "help_friend_crossed") : UIImage(named: "help_friend"), for: .normal)
        element.isEnabled = !viewModel.hasFriendCallUsed
        element.contentMode = .scaleAspectFit
        
        element.addTarget(self, action: #selector(callFriendButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var friendHelp: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(viewModel.hasAudienceHelpUsed ? UIImage(named: "help_audience_crossed") : UIImage(named: "help_audience"), for: .normal)
        element.isEnabled = !viewModel.hasAudienceHelpUsed
        element.contentMode = .scaleAspectFit
        
        element.addTarget(self, action: #selector(audienceHelpButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Logic

    
   
    @objc func answerButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = nil
        
        callHelp.isEnabled = false
        halfHelp.isEnabled = false
        friendHelp.isEnabled = false
        
        if let answer = sender.titleLabel?.text {
            let trimmedAnswer = String(answer.suffix(from: answer.index(answer.startIndex, offsetBy: 3)))
            print(trimmedAnswer)
            viewModel.selectAnswer(trimmedAnswer)
        }
        sender.setBackgroundImage(UIImage(named: "question_selected"), for: .normal)
        
        
        let answerButtons = [answerA, answerB, answerC, answerD]
        
        for button in answerButtons {
            guard button != sender else {
                // If the button's text does not contain answer1 or answer2, skip to the next iteration
                continue
            }
            
            button.isEnabled = false
        }
        
    }
    
    
    
    @objc func fiftyFiftyButtonTapped(_ sender: UIButton) {
        viewModel.fiftyFiftyButtonTapped()
    }
    
    @objc func callFriendButtonTapped(_ sender: UIButton) {
        viewModel.callFriendButtonTapped()
    }
    
    @objc func audienceHelpButtonTapped(_ sender: UIButton) {
        viewModel.audienceHelpButtonTapped()

    }
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setView()
        setupConstraints()
        
        view.addSubview(progressBar)
        
        variantsStackView.spacing = 15
        footerStackView.spacing = 15
    }
    
    private func setView() {
        
        headerStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillProportionally,
            subViews: [
                questionNumberLabel,
                logo,
                actualSumLabel
            ])
        
        variantsStackView = UIStackView(
            axis: .vertical,
            distribution: .fillProportionally,
            subViews: [
                answerA,
                answerB,
                answerC,
                answerD
            ])
        
        footerStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillProportionally,
            subViews: [
                halfHelp,
                callHelp,
                friendHelp,
            ])
        
        mainStackView = UIStackView(
            axis: .vertical,
            distribution: .fillProportionally,
            subViews: [
                headerStackView,
                questionView,
                variantsStackView,
                footerStackView
            ])
        
        
        view.addSubview(backgroungImageView)
        view.addSubview(mainStackView)
        view.addSubview(headerStackView)
        view.addSubview(questionView)
        questionView.addSubview(questionBackgroundImage)
        questionView.addSubview(questLabel)
        view.addSubview(variantsStackView)
        view.addSubview(footerStackView)
        
    }
    
    //by Paddubny
    private func setupProgressBarConstraints() {
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    //by Paddubny
    private func startProgressBarAnimation() {
        self.progressBar.setProgress(1, animated: false)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.progress -= Float(timer.timeInterval) / Float(self.duration)
            self.progressBar.setProgress(self.progress, animated: false)
            
            if self.progress <= 0 {
                timer.invalidate()
                //stop the game...
                switch viewModel.getQuestionNumber() {
                case 1...5:
                    self.navigationController?.pushViewController(StartGameViewController(gameViewModel: GameViewModel(), winning: 0), animated: true)
                case 6...10:
                    self.navigationController?.pushViewController(StartGameViewController(gameViewModel: GameViewModel(), winning: 1_000), animated: true)
                default:
                    self.navigationController?.pushViewController(StartGameViewController(gameViewModel: GameViewModel(), winning: 32_000), animated: true)
                }
            }
        }
    }
}

// MARK: - ViewModel Delegate
// Created by Ilya Paddubny on 01.03.2024.
extension QuestionViewController: GameDelegate {
    func fiftyFiftyButtonUsed(wrongAnswer1: String, wrongAnswer2: String) {
        deactiveteTwoButtonsWith(answer1: wrongAnswer1, answer2: wrongAnswer2)
        halfHelp.setImage(UIImage(named: "help_50_50_crossed"), for: .normal)
        halfHelp.isEnabled = false
    }
    
    func audienceHelpButtonUsed(audienceAnswer: String) {
        showAlertWith(title: "Friend's help results", message: audienceAnswer)
        friendHelp.setImage(UIImage(named: "help_audience_crossed"), for: .normal)
        friendHelp.isEnabled = false
    }
    
    func callFriendButtonUsed(friendsAnswer: String) {
        showAlertWith(title: "Audience help results", message: friendsAnswer)
        callHelp.setImage(UIImage(named: "help_friend_crossed"), for: .normal)
        callHelp.isEnabled = false
    }
    
    func selectCurrectAnswer(_ correctAnswer: String) {
        selectButtonWith(text: correctAnswer)
    }
    
    func proceedToTheNextQuestion(_ question: Question, questionNumber: Int) {
        let progressVC = ProgressViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(progressVC, animated: true)
    }
    
    func onShowTheQuestion(_ question: Question, questionNumber: Int) {
        
        questionNumberLabel.text = "Question \n\(viewModel.getQuestionNumber())"
        
        actualSumLabel.text = "\(amountOfMoneyInInts[viewModel.getQuestionNumber()-1])USD"
        
        if let decodedString = question.question.htmlDecoded {
            questLabel.text = "\(decodedString)"
        }
       
        
        var answers = question.incorrectAnswers
        answers.append(question.correctAnswer)
        
        configureAnswerButtons(withQuestions: answers.shuffled())
        
        print(question.question)
        print(questionNumber)
    }
    
    func selectButtonWith(text: String) {
        let answerButtons = [answerA, answerB, answerC, answerD]
        
        for button in answerButtons {
            guard let buttonText = button.titleLabel?.text,
                  buttonText.contains(text) else {
                // If the button's text does not contain answer1 or answer2, skip to the next iteration
                continue
            }
            
            button.setBackgroundImage(UIImage(named: "question_right"), for: .normal)
        }
        
    }
    
    func configureAnswerButtons(withQuestions questions: [String]) {
        let answerButtons = [answerA, answerB, answerC, answerD]
        
        for (index, question) in questions.enumerated() {
            guard index < answerButtons.count else {
                break
            }
            
            let button = answerButtons[index]
            
            let answerLetter = String(UnicodeScalar(65 + index)!)
            let labeledQuestion = "\(answerLetter): \(question)"
            
            let attributedTitle = NSMutableAttributedString(string: labeledQuestion)
            attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "AnswerVariantText") as Any, range: NSRange(location: 0, length: 2))
            attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 2, length: attributedTitle.length - 2))
            button.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    func endGame(moneyWon: Int) {
        print("Game ended - \(moneyWon)")
        if moneyWon == 0 {
            self.navigationController?.pushViewController(StartGameViewController(gameViewModel: GameViewModel(), winning: 0), animated: true)
        } else {
            //дошел до несгораемой суммы
            self.navigationController?.pushViewController(ProgressViewController(viewModel: viewModel, endingGame: true), animated: true)
        }
    }
    
    
    func deactiveteTwoButtonsWith(answer1: String, answer2: String) {
        
        let answerButtons = [answerA, answerB, answerC, answerD]
        
        for button in answerButtons {
            guard let buttonText = button.titleLabel?.text,
                  buttonText.contains(answer1) || buttonText.contains(answer2) else {
                // If the button's text does not contain answer1 or answer2, skip to the next iteration
                continue
            }
            
            button.setBackgroundImage(UIImage(named: "question_no_option"), for: .normal)
            button.isEnabled = false
            button.titleLabel?.text = ""

        }
    }
    
    func showAlertWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alertController, animated: true, completion: nil)
    }
    
}


// MARK: - Setup constraints

extension QuestionViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroungImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroungImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 13),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -13),
            
            headerStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            headerStackView.heightAnchor.constraint(equalToConstant: 124),
            
            questionNumberLabel.widthAnchor.constraint(equalTo: logo.widthAnchor),
            logo.widthAnchor.constraint(equalTo: actualSumLabel.widthAnchor),
            questionNumberLabel.heightAnchor.constraint(equalTo: logo.heightAnchor),
            logo.heightAnchor.constraint(equalTo: actualSumLabel.heightAnchor),
            
            questionView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor),
            questionView.bottomAnchor.constraint(equalTo: variantsStackView.topAnchor),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionView.heightAnchor.constraint(equalToConstant: 350),
            
            variantsStackView.topAnchor.constraint(equalTo: questionView.bottomAnchor),
            variantsStackView.bottomAnchor.constraint(equalTo: footerStackView.topAnchor, constant: -20),
            variantsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            variantsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            variantsStackView.heightAnchor.constraint(equalToConstant: 250),
            
            answerA.heightAnchor.constraint(equalTo: answerB.heightAnchor),
            answerB.heightAnchor.constraint(equalTo: answerC.heightAnchor),
            answerC.heightAnchor.constraint(equalTo: answerD.heightAnchor),
            answerD.heightAnchor.constraint(equalTo: answerA.heightAnchor),
            
            questionBackgroundImage.topAnchor.constraint(equalTo: questLabel.topAnchor, constant: -30),
            questionBackgroundImage.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            questionBackgroundImage.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            questionBackgroundImage.centerYAnchor.constraint(equalTo: questionView.centerYAnchor),
            
            questLabel.centerYAnchor.constraint(equalTo: questionBackgroundImage.centerYAnchor),
            
            questLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            questLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerStackView.topAnchor.constraint(equalTo: variantsStackView.bottomAnchor),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            footerStackView.heightAnchor.constraint(equalToConstant: 120),
            
            callHelp.widthAnchor.constraint(equalTo: friendHelp.widthAnchor),
            friendHelp.widthAnchor.constraint(equalTo: halfHelp.widthAnchor),
            halfHelp.widthAnchor.constraint(equalTo: callHelp.widthAnchor),
        ])
    }
}


extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, subViews: [UIView]) {
        self.init(arrangedSubviews: subViews)
        
        self.axis = axis
        self.distribution = distribution
        self.spacing = 0
        self.alignment = .fill
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}



extension String {
    var htmlDecoded: String? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        do {
            let attributedString = try NSAttributedString(data: data, options: attributedOptions, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Error decoding HTML string: \(error)")
            return nil
        }
    }
}
