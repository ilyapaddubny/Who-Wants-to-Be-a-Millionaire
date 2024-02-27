//
//  QuestionTableVC.swift
//  Who Wants to Be a Millionaire
//
//  Created by Maryna Bolotska on 27/02/24.
//

import UIKit
import SnapKit


class QuestionTableVC: UIViewController {
    let questions = (1...15).reversed().map { "Question \($0)" }
    let amountOfMoney = (1...15).map { "\($0) USD" }
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background_empty")
        return image
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


extension QuestionTableVC {
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

extension QuestionTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier, for: indexPath) as? QuestionCell else { fatalError("Unable to dequeue cell") }
        cell.questionLabel.text = questions[indexPath.row]
        cell.amountOfMoneyLabel.text = amountOfMoney[indexPath.row]
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        switch indexPath.row {
          case 0:
              cell.questionImageView.image = UIImage(named: "question_level_yellow")
          case 5, 10:
              cell.questionImageView.image = UIImage(named: "question_level_blue")
          case 14:
              cell.questionImageView.image = UIImage(named: "question_level_green")
          default:
              cell.questionImageView.image = UIImage(named: "question_level_purple")
          }
        
          return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
     
    }
    
}


