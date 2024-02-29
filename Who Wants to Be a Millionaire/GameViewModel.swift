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
    func proceedToTheNextQuestion(_ question: Question, questionNumger: Int)
    
    
    func endGame(moneyWon: Int)
    func updateTimerLabel(_ timeRemaining: Int)
    
    func fiftyFiftyButtonTapped()
    func audienceHelpButtonTapped()
    func takeMoneyButtonTapped()
}

protocol EndGameDelegate: AnyObject {
    func endGame(moneyWon: Int)
}


class GameViewModel {
    weak var gameDelegate: GameDelegate? //QuestionViewController
    weak var endGame: EndGameDelegate? //progress VC
    
    let dataManager = DataManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    private var questions: [Question] = []
    
    private var currentQuestionIndex = 0
    
    private var timer: Timer?
    private var remainingTime = 30
    
    private var hasFiftyFiftyUsed = false
    private var hasAudienceHelpUsed = false
    private var hasPhoneFriendUsed = false
    
    init(delegate: GameDelegate) {
        gameDelegate = delegate
        loadQuestions()
    }
    
    
    func loadQuestions() {
        dataManager.fetchDataOnline { [weak self] result in
            switch result {
            case .success(let questionsByLevel):
                for (level, questions) in questionsByLevel {
                    self?.questions.append(contentsOf: questions)
                    print(questions.count)
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
    
    
    private func selectAnswer(_ selectedAnswer: String) {
        //  answer is selected
        playDecisionMadeSound()
        
        //TODO: подождать 3 секунды...
        showCorrectAnswer()
        
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            // answer is correct.
            playCorrectAnswerSound()
            currentQuestionIndex += 1
            //TODO: подождать 2 секунды...
            //TODO: если вопрос не последний - оповести делегат, о переходе к следующему вопросу:
            gameDelegate?.proceedToTheNextQuestion(questions[currentQuestionIndex], questionNumger: currentQuestionIndex + 1)
            //TODO: если вопрос был последний - надо проиграть звук победи и опосестить делегат об окончании игры с суммой выйгрыша = 1 миллион (делегат должен реализовать разделение логики, если сумма выигрыша не = 0)
        } else {
            // answer is wrong
            if (0...4).contains(currentQuestionIndex) {
                // user wins 0 USD
                playWrongAnswerSound()
                //TODO: подождать 2 секунды...
                //TODO: опосестить делегат об окончании игры с суммой выйгрыша = 0 (делегат должен реализовать разделение логики, если сумма выигрыша = 0)
            } else {
                // user wins 0 USD
                playWrongAnswerSound()
                //TODO: подождать 2 секунды...
                //TODO: выбрать нужную несгораемую сумму
                //TODO: опосестить делегат об окончании игры с суммой выйгрыша = несгораемой сумме (делегат должен реализовать разделение логики, если сумма выигрыша не = 0)
            }
        }

    }
    
    private func showCorrectAnswer() {
        // Показать правильный ответ после ответа пользователя
        gameDelegate?.selectCurrectAnswer(questions[currentQuestionIndex].correctAnswer)
    }
    
    
    // MARK: - Help buttons intents
    func fiftyFiftyButtonTapped() {
        if !hasFiftyFiftyUsed {
            // Реализация подсказки "50/50"
            // Удаление двух неверных ответов
            
            hasFiftyFiftyUsed = true
        }
    }
    
    func audienceHelpButtonTapped() {
        if !hasAudienceHelpUsed {
            // Реализация подсказки "Помощь зала"
            // Показать всплывающее уведомление с самым популярным ответом зала
            
            
            hasAudienceHelpUsed = true
        }
    }
    
    func phoneFriendButtonTapped() {
        if !hasPhoneFriendUsed {
            // Реализация подсказки "Звонок другу"
            // Показать всплывающее уведомление с ответом от друга
            
            
            hasPhoneFriendUsed = true
        }
    }
    
    func takeMoneyButtonTapped() {
        // Реализация кнопки "Забрать деньги"
        
    }
    
    // MARK: - Sounds
    private func playGameStartsSound() {
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
    
    
}
