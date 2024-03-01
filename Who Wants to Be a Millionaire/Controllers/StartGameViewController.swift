//
//  StartGameViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 26.02.2024.
//

import UIKit

class StartGameViewController: UIViewController {
    
    let logo = UIImageView()
    let playButton = UIButton()
    let rulesButton = UIButton()
    let stackView = UIStackView()
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "background_crowd")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.addSubview(backgroundImageView)
        style()
        layout()
        
        // Add target action to play button
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        rulesButton.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
    }
    
    @objc private func playButtonTapped() {
        
        let gameViewModel = GameViewModel() // Assuming you have a GameViewModel initializer
        let gameVC = QuestionViewController(viewModel: gameViewModel)
        gameViewModel.gameDelegate = gameVC
        gameViewModel.startGame()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @objc private func rulesButtonTapped() {
        self.navigationController?.pushViewController(RulesViewController(), animated: true)
    }
    
}

extension UIColor {
    static let myPurple = UIColor(_colorLiteralRed: 85/255, green: 20/255, blue: 95/255, alpha: 1)
}

extension StartGameViewController {
    private func style() {
        logo.image = UIImage(named: "logo.png")
        logo.contentMode = .scaleAspectFit
        
        playButton.setTitle("Start the game!", for: .normal)
        playButton.backgroundColor = .myPurple
        playButton.layer.cornerRadius = 10
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        rulesButton.setTitle("Rules", for: .normal)
        rulesButton.backgroundColor = .myPurple
        rulesButton.layer.cornerRadius = 10
        rulesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    
    private func layout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(rulesButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            playButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

