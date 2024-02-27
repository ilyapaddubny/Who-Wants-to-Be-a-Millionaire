//
//  GameViewModel.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 27.02.2024.
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    
}

class GameViewModel {
    weak var delegate: GameViewModelDelegate?
    let dataManager = DataManager()
    
    init(delegate: GameViewModelDelegate) {
        self.delegate = delegate
        loadQuestions()
    }
    
    func loadQuestions() {
        dataManager.fetchDataOnline { result in
            switch result {
            case .success(let questionsByLevel):
                for (level, questions) in questionsByLevel {
                    print("Questions for level \(level):")
                    for question in questions {
                        print("ℹ️ - \(question.question)")
                        //
                        //
                        //
                    }
                }
            case.failure(let error):
                print("⚠️ Failed to load questions: \(error.localizedDescription)")

            }
        }
    }
}
