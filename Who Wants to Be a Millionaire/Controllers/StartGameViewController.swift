//
//  StartGameViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 26.02.2024.
//

import UIKit

class StartGameViewController: UIViewController {
    let gameViewModel: GameViewModel
    let logo = UIImageView()
    let playButton = UIButton()
    let rulesButton = UIButton()
    let stackView = UIStackView()
    let infoLabel = UILabel()
    var winning: Int? = nil

    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "background_crowd")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    init(gameViewModel: GameViewModel, winning: Int? = nil) {
        self.gameViewModel = gameViewModel
        self.winning = winning
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.addSubview(backgroundImageView)
        style()
        layout()
        if let winning = winning {
            setAtributedText(winningAmount: winning)
        }
        
        // Add target action to play button
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        rulesButton.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
    }
    
    @objc private func playButtonTapped() {
        let gameVC = QuestionViewController(viewModel: gameViewModel)
        gameViewModel.gameDelegate = gameVC
        gameViewModel.startGame()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc private func rulesButtonTapped() {
        self.navigationController?.pushViewController(RulesViewController(gameViewModel: gameViewModel), animated: true)
    }
    
}

extension UIColor {
    static let myPurple = UIColor(_colorLiteralRed: 85/255, green: 20/255, blue: 95/255, alpha: 1)
}

extension StartGameViewController {
    private func style() {
        logo.image = UIImage(named: "logo.png")
        logo.contentMode = .scaleAspectFit
        
        
        // Adjusting the size of the logo
        logo.widthAnchor.constraint(equalToConstant: 250).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        playButton.setTitle("Start the game!", for: .normal)
        playButton.backgroundColor = .myPurple
        playButton.layer.cornerRadius = 10
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        rulesButton.setTitle("Rules", for: .normal)
        rulesButton.backgroundColor = .myPurple
        rulesButton.layer.cornerRadius = 10
        rulesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        infoLabel.textAlignment = .center // Center the text
        infoLabel.textColor = .white // Set text color
        infoLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        infoLabel.numberOfLines = 2 // Allow multiple lines
        
    }
    
    func setAtributedText(winningAmount: Int) {
        let winningMessage = "The winning is\n"
        if let winning {
            let winningAmountText = "\(winning) USD"
            let attributedText = NSMutableAttributedString(string: winningMessage + winningAmountText)
            
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 35, weight: .bold), range: NSRange(location: 0, length: winningMessage.count))
            attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 45), range: NSRange(location: winningMessage.count, length: winningAmountText.count))
            attributedText.addAttribute(.foregroundColor, value: UIColor.yellow, range: NSRange(location: winningMessage.count, length: winningAmountText.count))
            infoLabel.attributedText = attributedText
        }
        
        
        
        
    }
    
    private func layout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(infoLabel)

        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(rulesButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            playButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

