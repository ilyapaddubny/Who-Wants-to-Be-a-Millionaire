//
//  RulesViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Максим Япринцев on 27.02.2024.
//

import UIKit

class RulesViewController: UIViewController {
    let gameViewModel: GameViewModel
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        configureRulesVC()
    }
    

    private func configureRulesVC() {

        let backgroundPicture = UIImageView(image: UIImage(named: "background_empty"))
        view.addSubview(backgroundPicture)
        backgroundPicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundPicture.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundPicture.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundPicture.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundPicture.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        
        var textField = UITextView()
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        textField.textColor = .white
        textField.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1)
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = CGColor(red: 163/255, green: 198/255, blue: 242/255, alpha: 1)
        textField.layer.borderWidth = 3
        textField.isEditable = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.text = "Who Wants to Be a Millionaire? is a quiz competition where contestants have to correctly answer a series of multiple-choice questions in order to advance to the next level / question. There are 15 questions in total and each question is worth a specific amount of money and no time limit is placed on contestants to come up with an answer. Contestants also get three Lifelines to assist them if they get stuck on a particular question.\n\nThe Who Wants to Be a Millionaire questions are structured according to five different Levels with each level increasing in difficulty. Each level contains three questions.\n\nQuestions that are grouped into the same level will all be of similar difficulty. For example: Questions 1-3 make up the first Level and will contain the easiest questions. The second Level (Questions 4 – 6) will be slightly more difficult, followed by the third Level (Questions 7 – 9). The fourth Level (Questions 10-12) will consist of really difficult questions, followed by the fifth, and last, level (Questions 13 – 15) that will pose the most difficult questions of the game.\n\nIt’s important to remember that the questions which make up each level will not necessarily relate to the same or even similar topics, but their overall level of difficulty will be the same. Also note that the question Levels should not be confused with the Safe Havens or the Question Value Structure that are both explained below.\n\nThere are three ‘safe havens’ in the question structure (Questions five, ten and fifteen). Contestants accumulate money with each correct answer, but should the they answer incorrectly before reaching a safe haven, they stand to lose a large amount of winnings. Below is a summary of the question value structure:\n\nQuestion 1 $100\nQuestion 2 $200\nQuestion 3 $300\nQuestion 4 $500\n\nQuestion 5 - $1,000 Safe Haven.\n\nIf contestants get this question wrong, they leave with nothing. If this question is answered correctly, contestants are guaranteed $1,000 even if the answer incorrectly before reaching the next safe haven at Question 10.\n\nQuestion 6 $2,000\nQuestion 7 $4,000\nQuestion 8 $8,000\nQuestion 9 $16,000\nQuestion 10 - $32,000 Safe Haven.\n\nIf contestants get this question wrong, they leave with $1,000. If this question is answered correctly, contestants are guaranteed $32,000 even if the answer incorrectly before reaching Question 15.\n\nQuestion 11 $64,000\nQuestion 12 $125,000\nQuestion 13 $250,000\nQuestion 14 $500,000\nQuestion 15 - $1,000,000\n\nLifelines\n\nContestants are allowed three Lifelines that they can use at any point during the game. Each Lifeline can only be used once.\n\n50/50 – removes two wrong answers from the multiple-choice selection, leaving the contestant with only one correct and one incorrect option. This means they have a 50/50 chance.\n\nAsk the Audience – the audience is asked the same question as the contestant and a quick poll is done to show their answers. If the chart shows a clear majority for a specific answer, this Lifeline can be extremely helpful, but it’s still up to the contestant whether or not to go with the results obtained from the audience.\n\nPhone a Friend – Contestants are allowed to make a 30-second call to a friend or family member and ask them if they know the answer to the question."
        
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.backgroundColor = UIColor(red: 53/255, green: 6/255, blue: 75/255, alpha: 1)
        button.layer.cornerRadius = 6
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 261),
            button.heightAnchor.constraint(equalToConstant: 47),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        button.setTitle("Back to main", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    
    @objc func buttonTapped() {
        self.navigationController?.pushViewController(StartGameViewController(gameViewModel: gameViewModel), animated: true)
    }
}
