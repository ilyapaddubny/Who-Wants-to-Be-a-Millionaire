//
//  QuestionCell.swift
//  Who Wants to Be a Millionaire
//
//  Created by Maryna Bolotska on 27/02/24.
//

import UIKit

class QuestionCell: UITableViewCell {
    static let identifier = "QuestionCell"
    
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
        label.font = UIFont(name: "Roboto", size: 20)
         label.textColor = .white
         return label
     }()
     
     let amountOfMoneyLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont(name: "Roboto", size: 20)
         label.textColor = .white
          return label
      }()


}

extension QuestionCell {
    func initialize() {
        contentView.addSubview(questionImageView)
        questionImageView.addSubview(questionLabel)
        questionImageView.addSubview(amountOfMoneyLabel)
        
        questionImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        }
        
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(amountOfMoneyLabel.snp.leading).offset(-10)
        }
        
        amountOfMoneyLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(38)
        }
    }
}
