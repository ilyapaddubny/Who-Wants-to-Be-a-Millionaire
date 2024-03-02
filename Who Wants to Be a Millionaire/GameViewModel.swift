//
//  GameViewModel.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 27.02.2024.
//

import Foundation
import AVFoundation


protocol GameDelegate: AnyObject {
    func selectCurrectAnswer(_ correctAnswer: String)
    func proceedToTheNextQuestion(_ question: Question, questionNumber: Int)
    func onShowTheQuestion(_ question: Question, questionNumber: Int)
    
    func endGame(moneyWon: Int)
    
    func fiftyFiftyButtonUsed(wrongAnswer1: String, wrongAnswer2: String)
    func audienceHelpButtonUsed(audienceAnswer: String)
    func callFriendButtonUsed(friendsAnswer: String)
    
}


class GameViewModel {
    weak var gameDelegate: GameDelegate? //QuestionViewController
    
    let dataManager = DataManager()
    var helpButtonsInactive = false
    private var audioPlayer: AVAudioPlayer?
    
    private var questions: [Question] = []
    
    private var currentQuestionIndex = 0
    
    var hasFiftyFiftyUsed = false
    var hasAudienceHelpUsed = false
    var hasFriendCallUsed = false
    
    init() {
        loadQuestions()
    }
    
    
    func loadQuestions() {
        dataManager.fetchDataOnline(questionsByLevel: .easy, completion: { [weak self] result in
            switch result {
            case .success(let questions):
                print("⚠️ \(questions)")
                self?.questions = questions
            case .failure(let error):
                print("⚠️ Failed to load questions: \(error.localizedDescription)")
            }
        })
    }
    func startGame() {
        playTimeTickingSound()
        helpButtonsInactive = false
        currentQuestionIndex = 0
        gameDelegate?.onShowTheQuestion(questions[currentQuestionIndex], questionNumber: currentQuestionIndex+1)
    }
    
    func goToNextQuestion() {
        currentQuestionIndex += 1
        playTimeTickingSound()
        gameDelegate?.onShowTheQuestion(questions[currentQuestionIndex], questionNumber: currentQuestionIndex)
    }
    
    func getQuestionNumber() -> Int {
        currentQuestionIndex + 1
    }
    
    
    func selectAnswer(_ selectedAnswer: String) {
        //  answer is selected
        playDecisionMadeSound()
        print("ℹ️ \(currentQuestionIndex)")
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timeAfterAnswer) {
            // After 3 seconds, show the correct answer
            self.showCorrectAnswer()
            self.helpButtonsInactive = false
            
            if selectedAnswer == self.questions[self.currentQuestionIndex].correctAnswer {
                // answer is correct.
                self.currectAnswerLogic()
                
            } else {
                // answer is wrong
                self.wrongAnswerLogic()
                
            }
        }
    }
    
    private func currectAnswerLogic() {
        self.playCorrectAnswerSound()
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timeAfterAnswer) {
            if self.currentQuestionIndex == 14 {
                //если вопрос был последний - надо проиграть звук победи и опосестить делегат об окончании игры с суммой выйгрыша = 1 миллион
                self.playGameWinningSound()
                self.gameDelegate?.endGame(moneyWon: 1_000_000)
            } else {
                //если вопрос не последний - оповести делегат, о переходе к следующему вопросу:
                self.gameDelegate?.proceedToTheNextQuestion(self.questions[self.currentQuestionIndex], questionNumber: self.currentQuestionIndex)
            }
        }
    }
    
    private func wrongAnswerLogic() {
        self.playWrongAnswerSound()
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.timeAfterAnswer) {
            //опосестить делегат об окончании игры с суммой выйгрыша = 0 (делегат должен реализовать разделение логики, если сумма выигрыша = 0)
            switch self.currentQuestionIndex {
            case 0...5:
                self.gameDelegate?.endGame(moneyWon: 0)
            case 6...10:
                self.gameDelegate?.endGame(moneyWon: 1000)
            case 11..<15:
                self.gameDelegate?.endGame(moneyWon: 32000)
            default:
                print("Answer is not within the specified ranges")
            }
            
            self.stopMusic()
        }
    }
    
    private func showCorrectAnswer() {
        // Показать правильный ответ после ответа пользователя
        gameDelegate?.selectCurrectAnswer(questions[currentQuestionIndex].correctAnswer)
    }
    
    
    // MARK: - Help buttons intents
    func fiftyFiftyButtonTapped() {
        if !hasFiftyFiftyUsed, !helpButtonsInactive {
            print("fiftyFiftyButtonTapped")
            // Реализация подсказки "50/50"
            // Удаление двух неверных ответов
            gameDelegate?.fiftyFiftyButtonUsed(wrongAnswer1: questions[currentQuestionIndex].incorrectAnswers[0], wrongAnswer2: questions[currentQuestionIndex].incorrectAnswers[1])
            hasFiftyFiftyUsed = true
            helpButtonsInactive = true
        }
    }
    
    func audienceHelpButtonTapped() {
        if !hasAudienceHelpUsed, !helpButtonsInactive {
            print("audienceHelpButtonTapped")
            // Зал должен ответить на вопрос правильно с вероятностью 70%
            
            let audienceAnswer = getBoolWithProbability(of: 70) ? questions[currentQuestionIndex].correctAnswer : questions[currentQuestionIndex].incorrectAnswers.first
            
            gameDelegate?.audienceHelpButtonUsed(audienceAnswer: audienceAnswer ?? "No answer")
            
            hasAudienceHelpUsed = true
            helpButtonsInactive = true
        }
    }
    
    func callFriendButtonTapped() {
        if !hasFriendCallUsed, !helpButtonsInactive {
            print("phoneFriendButtonTapped")
            // Звонок другу с вероятностью 80% даст правильный ответ
            
            let friendsAnswer = getBoolWithProbability(of: 80) ? questions[currentQuestionIndex].correctAnswer : questions[currentQuestionIndex].incorrectAnswers.first
            
            gameDelegate?.callFriendButtonUsed(friendsAnswer: friendsAnswer ?? "No answer")
            
            hasFriendCallUsed = true
            helpButtonsInactive = true
        }
    }
    
    func getBoolWithProbability(of percent: Int) -> Bool {
        // Generate a random number between 0 and 99
        let randomNumber = Int.random(in: 0...percent)
        
        // Probability of 80%
        if randomNumber < 80 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Sounds
    private func playGameWinningSound() {
        playSound("sound_game_starts")
    }
    
    private func playDecisionMadeSound() {
        playSound("sound_decision_made")
    }
    
    private func playCorrectAnswerSound() {
        playSound("sound_right_answer")
    }
    
    private func playTimeTickingSound() {
        playSound("sound_time_ticking")
    }
    
    private func playWrongAnswerSound() {
        playSound("sound_wrong_answer")
    }
    
    private func playSound(_ soundName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    private struct Constants {
        static let timeAfterAnswer: TimeInterval = 1
    }
    
    
}
