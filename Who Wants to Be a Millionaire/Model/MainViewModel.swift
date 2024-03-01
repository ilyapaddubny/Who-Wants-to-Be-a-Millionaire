//
//  MainViewModel.swift
//  Who Wants to Be a Millionaire
//
//  Created by Maryna Bolotska on 29/02/24.
//

import Foundation
protocol AnswerSelectionDelegate: AnyObject {
    func makeSelectionOfRightAnswer(answer: String)
    func makeSelectionOfWrongAnswer(answer: String)
    func winFireproofAmount()
    func endGame()
}

class MainViewModel {
    let soundManager = SoundManager.shared
    weak var delegate: AnswerSelectionDelegate?
    var currentQuestion: Question
    var currentQuestionNumber = 0
    var questions: [Question] = []
    
    init(currentQuestion: Question) {
          self.currentQuestion = currentQuestion
      }
  
    
    func answerDidChoose(answer: String) {
        soundManager.playSound(fileName: SoundsNames.decisionMade, fileExtension: "mp3")
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
             guard let self = self else { return }
             
             let isCorrect = answer == self.questions[self.currentQuestionNumber].correctAnswer
             
             if isCorrect {
                 soundManager.playSound(fileName: SoundsNames.correctAnswer, fileExtension: "mp3")
                 //shows next question
                 self.delegate?.makeSelectionOfRightAnswer(answer: self.currentQuestion.correctAnswer)
             }
               else if currentQuestionNumber == 15 {
                  
                   //won the game
               }
         else if !isCorrect && (self.currentQuestionNumber >= 0 && self.currentQuestionNumber < 5) {
             soundManager.playSound(fileName: SoundsNames.wrongAnswer, fileExtension: "mp3")
            self.delegate?.endGame()
            
         }  else if !isCorrect && (self.currentQuestionNumber >= 5) {
             soundManager.playSound(fileName: SoundsNames.wrongAnswer, fileExtension: "mp3")
             self.delegate?.winFireproofAmount()
             self.delegate?.endGame()
         }
             currentQuestionNumber += 1
         }
     }
}
