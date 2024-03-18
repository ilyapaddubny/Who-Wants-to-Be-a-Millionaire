//
//  Constants.swift
//  Who Wants to Be a Millionaire
//
//  Created by Maryna Bolotska on 28/02/24.
//

import UIKit


enum Images {
    static let backgroundImage = UIImage(named: "background_empty")
    static let yellowLevel = UIImage(named: "question_level_yellow")
    static let blueLevel = UIImage(named: "question_level_blue")
    static let greenLevel = UIImage(named: "question_level_green")
    static let purpleLevel = UIImage(named: "question_level_purple")
}


enum SoundsNames {
    static let decisionMade = "sound_decision_made"
    static let startOfGame = "sound_game_starts"
    static let correctAnswer = "sound_right_answer"
    static let timeTicking = "sound_time_ticking"
    static let wrongAnswer = "sound_wrong_answer"
}


enum QuestionLevel: String, CaseIterable {
    case easy = "https://opentdb.com/api.php?amount=15&difficulty=easy&type=multiple"
    case medium = "https://opentdb.com/api.php?amount=5&difficulty=medium&type=multiple"
    case hard = "https://opentdb.com/api.php?amount=5&difficulty=hard&type=multiple"
    
}





