//
//  GameViewModel.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 27.02.2024.
//

import Foundation
import AVFoundation


protocol GameViewModelDelegate: AnyObject {
    func showQuestion(_ question: Question)
    func showCorrectAnswer(_ correctAnswer: String)
    func endGame(withMessage message: String)
    func updateTimerLabel(_ timeRemaining: Int)
}

class GameViewModel {
    weak var delegate: GameViewModelDelegate?
    let dataManager = DataManager()
    private var audioPlayer: AVAudioPlayer?
    
    
    private var questions: [Question] = []
    
    private var currentQuestionIndex = 0
    
    private var timer: Timer?
    private var remainingTime = 30
    
    private var totalEarnings = 0
    
    private var hasFiftyFiftyUsed = false
    private var hasAudienceHelpUsed = false
    private var hasPhoneFriendUsed = false
    
    init(delegate: GameViewModelDelegate) {
        self.delegate = delegate
        playWrongAnswerSound()
        loadQuestions()
    }
    
    func loadQuestions() {
        dataManager.fetchDataOnline { [weak self] result in
            switch result {
            case .success(let questionsByLevel):
                for (level, questions) in questionsByLevel {
                    print("Questions for level \(level):")
                    self?.questions.append(contentsOf: questions)
                }
            case.failure(let error):
                print("⚠️ Failed to load questions: \(error.localizedDescription)")

            }
        }
    }
    
    
    func startGame() {
        // Начало игры
    }
    
    private func displayQuestion() {
        // Отображение вопроса и вариантов ответов
    }
    
    
    private func startTimer() {
        // Запуск таймера
    }
    
    private func stopTimer() {
        // Остановка таймера
    }
    
    
    private func checkAnswer(_ selectedAnswer: String) {
        // Проверка ответа пользователя
    }
    
    private func showCorrectAnswer() {
        // Показать правильный ответ после ответа пользователя
    }
    
    func fiftyFiftyButtonTapped() {
        // Реализация подсказки "50/50"
        // Удаление двух неверных ответов
        hasFiftyFiftyUsed = true
    }
    
    func audienceHelpButtonTapped() {
        // Реализация подсказки "Помощь зала"
        // Показать всплывающее уведомление с самым популярным ответом зала
        hasAudienceHelpUsed = true
    }
    
    func phoneFriendButtonTapped() {
        // Реализация подсказки "Звонок другу"
        // Показать всплывающее уведомление с ответом от друга
        hasPhoneFriendUsed = true
    }
    
    func takeMoneyButtonTapped() {
        // Реализация кнопки "Забрать деньги"
        delegate?.endGame(withMessage: "Вы забрали \(totalEarnings) рублей")
    }
    
    //MARK: - Sounds
    private func playGameStartsSound() {
        playSound("sound_game_starts")
    }
    
    private func playDecisionMadeSound() {
        playSound("sound_decision_made")
    }
    
     private func playRightAnswerSound() {
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
    
    
}
