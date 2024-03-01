

import UIKit


class ProgressViewController: UIViewController {
    let questions = (1...15).reversed().map { "Question \($0)" }
    var amountOfMoney = ["1000000 USD", "500000 USD", "250000 USD", "125000 USD", "64000 USD", "32000 USD", "16000 USD", "8000 USD", "4000 USD", "2000 USD", "1000 USD", "500 USD", "300 USD", "200 USD", "100 USD"]


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
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        button.backgroundColor = UIColor(red: 172/255, green: 148/255, blue: 23/255, alpha: 1)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        return button
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("CONTINUE THE GAME", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            tableView.heightAnchor.constraint(equalToConstant: 632),
            tableView.widthAnchor.constraint(equalToConstant: 321),
            
            grabMoneyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
                   grabMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
                   grabMoneyButton.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.5, constant: -17),
            grabMoneyButton.heightAnchor.constraint(equalToConstant: 54),
     
            continueButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
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

          return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

    }

}
