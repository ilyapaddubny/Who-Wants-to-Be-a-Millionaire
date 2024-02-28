//
//   QuestionTableVC.swift
//  Who Wants to Be a Millionaire
//
//  Created by Maryna Bolotska on 27/02/24.
//

import UIKit
import SnapKit


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

        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(34)
            make.top.equalToSuperview().offset(124)
            make.height.equalTo(632)
            make.width.equalTo(321)
        }
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
          case 14:
            cell.questionImageView.image = Images.greenLevel
          default:
            cell.questionImageView.image = Images.purpleLevel
          }

          return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

    }

}
