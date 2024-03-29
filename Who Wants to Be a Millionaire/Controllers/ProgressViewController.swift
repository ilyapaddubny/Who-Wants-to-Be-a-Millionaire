

import UIKit


class ProgressViewController: UIViewController {
    var endingGame = false
    let viewModel: GameViewModel
    let questions = (1...15).reversed().map { "Question \($0)" }
    var amountOfMoney = ["1000000 USD", "500000 USD", "250000 USD", "125000 USD", "64000 USD", "32000 USD", "16000 USD", "8000 USD", "4000 USD", "2000 USD", "1000 USD", "500 USD", "300 USD", "200 USD", "100 USD"]
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
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = Images.backgroundImage
        return image
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(ProgressViewCell.self, forCellReuseIdentifier: ProgressViewCell.identifier)
        return tv
    }()
    
    private let grabMoneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("TAKE THE MONEY", for: .normal)
        button.backgroundColor = .myPurple
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("CONTINUE THE GAME", for: .normal)
        button.backgroundColor = .myPurple
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.titleLabel?.numberOfLines = 0
        button.layer.cornerRadius = 15
        return button
    }()
    
    init(viewModel: GameViewModel, endingGame: Bool = false) {
        self.viewModel = viewModel
        self.endingGame = endingGame // in case to show VC just for couple of seconds
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        continueButton.isEnabled = viewModel.getQuestionNumber() == 15 ? false : true
        
        setupUI()
        grabMoneyButton.addTarget(self, action: #selector(grabMoneyButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        if endingGame {
            showEndingGame()
        }
    }
    
    private func showEndingGame() {
        //после неверного ответа, но пользователь дошел до несгораемой суммы
        continueButton.isHidden = true
        grabMoneyButton.isHidden = true
        
        let fireproofSum = {
            switch self.viewModel.getQuestionNumber() {
            case 0...5:
                0
            case 6...10:
                1000
            case 11..<15:
                32000
            case 15:
                1000000
            default:
                0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.pushViewController(StartGameViewController(gameViewModel: GameViewModel(), winning: fireproofSum()), animated: true)
        }
    }
    
    @objc
    func grabMoneyButtonTapped() {
        viewModel.stopMusic()
        self.navigationController?.pushViewController(StartGameViewController(gameViewModel: GameViewModel(), winning: amountOfMoneyInInts[viewModel.getQuestionNumber()-1]), animated: true)
        
    }
    
    @objc
    func continueButtonTapped() {
        let nextQuestionViewController = QuestionViewController(viewModel: viewModel)
        viewModel.gameDelegate = nextQuestionViewController
        
        viewModel.goToNextQuestion()
        self.navigationController?.pushViewController(nextQuestionViewController, animated: true)
    }
}


extension ProgressViewController {
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        view.addSubview(grabMoneyButton)
        view.addSubview(continueButton)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        grabMoneyButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            tableView.heightAnchor.constraint(equalToConstant: 670),
            tableView.widthAnchor.constraint(equalToConstant: 321),
            
            grabMoneyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            grabMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            grabMoneyButton.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.5, constant: -17),
            grabMoneyButton.heightAnchor.constraint(equalToConstant: 54),
            
            continueButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: grabMoneyButton.trailingAnchor, constant: 34),
            continueButton.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.5, constant: -17),
            continueButton.heightAnchor.constraint(equalToConstant: 54),
        ])
        
        
    }
}

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgressViewCell.identifier, for: indexPath) as? ProgressViewCell else { fatalError("Unable to dequeue cell") }
        cell.questionLabel.text = questions[indexPath.row]
        cell.amountOfMoneyLabel.text = amountOfMoney[indexPath.row]
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.questionImageView.image = Images.yellowLevel
        case 5, 10:
            cell.questionImageView.image = Images.blueLevel
        default:
            cell.questionImageView.image = Images.purpleLevel
        }
        
        if viewModel.getQuestionNumber() == 15-indexPath.row, !endingGame {
            cell.questionImageView.image = Images.greenLevel
        }
        
        if endingGame {
            switch viewModel.getQuestionNumber() {
            case 6...10:
                if 5 == 15-indexPath.row {
                    cell.questionImageView.image = Images.greenLevel
                }
            case 11...15:
                if 10 == 15-indexPath.row {
                    cell.questionImageView.image = Images.greenLevel
                }
            default: break
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
