//
//  QuestionViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Александр Крапивин on 27.02.2024.
//

import UIKit




class QuestionViewController: UIViewController {
    
    // MARK: - UI
    
    var questionNumber: Int = 1
    var actualSum: Int = 564_000
    
    
    
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
        element.font = .systemFont(ofSize: 30)
        element.textColor = .white
        element.textAlignment = .center
        element.numberOfLines = 0
        element.text = "Вопрос \n\(questionNumber)"
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var logo: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "logo")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var actualSumLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 30)
        element.textColor = .white
        element.textAlignment = .center
        element.numberOfLines = 0
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        element.text = numberFormatter.string(from: NSNumber(value: actualSum))
        
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
        element.text = "Вопрос"
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
        
        let attributedTitle = NSMutableAttributedString(string: "A:  Вариант")
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "AnswerVariantText") as Any, range: NSRange(location: 0, length: 2))
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 2, length: attributedTitle.length - 2))
        element.setAttributedTitle(attributedTitle, for: .normal)
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var answerB: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(named: "question_empty"), for: .normal)
        
        let attributedTitle = NSMutableAttributedString(string: "B:  Вариант")
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "AnswerVariantText") as Any, range: NSRange(location: 0, length: 2))
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 2, length: attributedTitle.length - 2))
        
        element.setAttributedTitle(attributedTitle, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var answerC: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(named: "question_empty"), for: .normal)
        
        let attributedTitle = NSMutableAttributedString(string: "C:  Вариант")
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "AnswerVariantText") as Any, range: NSRange(location: 0, length: 2))
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 2, length: attributedTitle.length - 2))
        element.setAttributedTitle(attributedTitle, for: .normal)
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var answerD: UIButton = {
        let element = UIButton()
        element.setBackgroundImage(UIImage(named: "question_empty"), for: .normal)
        
        let attributedTitle = NSMutableAttributedString(string: "D:  Вариант")
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "AnswerVariantText") as Any, range: NSRange(location: 0, length: 2))
        attributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 2, length: attributedTitle.length - 2))
        element.setAttributedTitle(attributedTitle, for: .normal)
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        element.titleEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 5)
        element.contentHorizontalAlignment = .left
        
        element.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    private lazy var halfHelp: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "help_50_50"), for: .normal)
        element.contentMode = .scaleAspectFit
        
        element.addTarget(self, action: #selector(halfHelpButton), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var callHelp: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "help_friend"), for: .normal)
        element.contentMode = .scaleAspectFit
        
        element.addTarget(self, action: #selector(callHelpButton), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var friendHelp: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "help_audience"), for: .normal)
        element.contentMode = .scaleAspectFit
        
        element.addTarget(self, action: #selector(friendHelpButton), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Logic

    
   
    @objc func answerButtonTapped(_ sender: UIButton) {
        print("He-he")
        sender.setBackgroundImage(UIImage(named: "question_selected"), for: .normal)
    }
    
    
    private var halfHelpButtonPressed = false
    private var callHelpButtonPressed = false
    private var friendHelpButtonPressed = false
    
    @objc func halfHelpButton(_ sender: UIButton) {
        if halfHelpButtonPressed == false {
            print("1")
            sender.setImage(UIImage(named: "help_50_50_crossed"), for: .normal)
            halfHelpButtonPressed = true
        }
    }
    
    @objc func callHelpButton(_ sender: UIButton) {
        if callHelpButtonPressed == false {
            print("2")
            sender.setImage(UIImage(named: "help_crossed"), for: .normal)
            callHelpButtonPressed = true
        }
    }
    
    @objc func friendHelpButton(_ sender: UIButton) {
        if friendHelpButtonPressed == false {
            print("3")
            sender.setImage(UIImage(named: "help_audience_crossed"), for: .normal)
            friendHelpButtonPressed = true
        }
    }
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupConstraints()
        
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
