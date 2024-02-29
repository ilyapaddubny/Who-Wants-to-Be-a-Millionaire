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
        //        self.view.insertSubview(backgroundImage, at: 0)
        //        view.backgroundColor = UIColor(UIImage(named: "background_crowd")!)
        view.addSubview(backgroundImageView)
        style()
        layout()
        
    }
}

extension UIColor {
    static let myPurple = UIColor(_colorLiteralRed: 85/255, green: 20/255, blue: 95/255, alpha: 1)
}

extension StartGameViewController {
    private func style() {
        logo.image = UIImage(named: "logo.png")
        logo.contentMode = .scaleAspectFit
        
        playButton.setTitle("Начать игру", for: .normal)
        playButton.backgroundColor = .myPurple
        playButton.layer.cornerRadius = 10
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        rulesButton.setTitle("Правила игры", for: .normal)
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

extension StartGameViewController: GameViewModelDelegate {
    func showQuestion(_ question: Question) {
        
    }
    
    func showCorrectAnswer(_ correctAnswer: String) {
        
    }
    
    func endGame(withMessage message: String) {
        
    }
    
    func updateTimerLabel(_ timeRemaining: Int) {
        
    }
    
    
}
