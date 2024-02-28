//
//  QuestionCell.swift
//  Who Wants to Be a Millionaire
//
//  Created by Maryna Bolotska on 27/02/24.
//

import UIKit

class ProgressViewCell: UITableViewCell {
    static let identifier = "ProgressViewCell"

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var questionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()

     let questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 20)
         label.textColor = .white
         return label
     }()

     let amountOfMoneyLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont(name: "Roboto-Regular", size: 20)
         label.textColor = .white
          return label
      }()


}

extension ProgressViewCell {
    func initialize() {
        contentView.addSubview(questionImageView)
        questionImageView.addSubview(questionLabel)
        questionImageView.addSubview(amountOfMoneyLabel)

        questionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            questionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            questionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            questionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            questionLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountOfMoneyLabel.leadingAnchor, constant: -10)
        ])

        
        amountOfMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amountOfMoneyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            amountOfMoneyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(lessThanOrEqualToConstant: 38)
        ])

    }
}
